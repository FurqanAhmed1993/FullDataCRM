using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Security.Principal;
using System.Threading.Tasks;

/// <summary>
/// Summary description for JwtManager
/// </summary>
public static class JwtManager
{

    private const string Secret = "db3OIsj+BXE9NZDy0t8W3TcNekrF+2d/1sFnWG4HnV8TZY30iTOdtVWJG8abWvB1GlOgJuQZdcF2Luqm/hccMw==";

    public static string GenerateToken(string LoginId, int expireMinutes = 1440)
    {
        var symmetricKey = Convert.FromBase64String(Secret);
        var tokenHandler = new JwtSecurityTokenHandler();

        var now = DateTime.UtcNow;
        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(new[]
                    {
                            new Claim(ClaimTypes.NameIdentifier, LoginId)
            }),

            Expires = now.AddMinutes(Convert.ToInt32(expireMinutes)),

            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(symmetricKey), SecurityAlgorithms.HmacSha256Signature)
        };

        SecurityToken securityToken = tokenHandler.CreateToken(tokenDescriptor);
        var token = tokenHandler.WriteToken(securityToken);

        return token;
    }

    private static ClaimsPrincipal GetPrincipal(string token)
    {
        try
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtToken = tokenHandler.ReadToken(token) as JwtSecurityToken;

            if (jwtToken == null)
                return null;

            var symmetricKey = Convert.FromBase64String(Secret);

            var validationParameters = new TokenValidationParameters()
            {
                RequireExpirationTime = true,
                ValidateIssuer = false,
                ValidateAudience = false,
                IssuerSigningKey = new SymmetricSecurityKey(symmetricKey)
            };
            SecurityToken validatedToken;
            var principal = tokenHandler.ValidateToken(token, validationParameters, out validatedToken);

            return principal;
        }

        catch (Exception)
        {
            return null;
        }

    }
    private static bool ValidateToken(string token, out string LoginId)
    {
        LoginId = null;

        var simplePrinciple = JwtManager.GetPrincipal(token);
        //ClaimsIdentity claimidentity=new ClaimsIdentity();
        //claimidentity.ide
        if (simplePrinciple == null)
            return false;

        var identity = (ClaimsIdentity)simplePrinciple.Identity;

        if (identity == null)
            return false;

        if (!identity.IsAuthenticated)
            return false;

        var LoginIdClaim = identity.FindFirst(ClaimTypes.NameIdentifier);

        LoginId = LoginIdClaim.Value;

        if (string.IsNullOrEmpty(LoginId))
            return false;

        // More validate to check whether username exists in system

        return true;
    }

    public static Task<IPrincipal> AuthenticateJwtToken(string token)
    {
        var LoginId = "";
        token = token.Split(' ')[1];
        if (ValidateToken(token, out LoginId))
        {
            // based on username to get more information from database in order to build local identity
            var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.NameIdentifier, LoginId)
                    // Add more claims if needed: Roles, ...
                };

            var identity = new ClaimsIdentity(claims, "Jwt");
            IPrincipal user = new ClaimsPrincipal(identity);

            return Task.FromResult(user);
        }

        return Task.FromResult<IPrincipal>(null);
    }
}