<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="InternalChat.aspx.cs" Inherits="InternalChat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .file-upload {
            cursor: pointer;
            display: flex;
            align-items: center;
        }

            .file-upload input {
                top: 0;
                left: 0;
                margin: 0;
                / Loses tab index in webkit if width is set to 0 / opacity: 0;
                filter: alpha(opacity=0);
            }

        .file-upload {
            cursor: pointer;
        }

            .file-upload input {
                top: 0;
                left: 0;
                margin: 0;
                /* Loses tab index in webkit if width is set to 0 */
                opacity: 0;
                filter: alpha(opacity=0);
            }

        .loader, scroll-top, span4 loaderBody, hf_IsCustomer, copyright, scroll-top {
            display: none;
        }

        .board-widgets-head {
            padding: 0px;
            margin-top: 5px;
        }

        .creating-group {
            height: 341px;
            overflow-y: scroll;
        }

            .creating-group::-webkit-scrollbar {
                width: 6px;
            }

            .creating-group::-webkit-scrollbar-track {
                background-color: #e4e4e4;
                border-radius: 100px;
            }

            .creating-group::-webkit-scrollbar-thumb {
                background-color: #1a7cc373;
                border-radius: 100px;
            }

        #tbl_grpmemberlist .RemoveMember {
            margin-left: 2px;
        }

        #tbl_grpmemberlist .makeMemberadmin {
            margin-left: 2px;
        }



        .table-paper tbody tr th:first-child, .table-paper tbody tr td:first-child {
            border-right: 0px;
            padding-left: 87px;
        }

        #chatframe {
            background: #ffffff;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            border-bottom: 1px solid #e0e3e8;
        }

            #chatframe #chatsidepanel {
                position: relative;
                padding: 1rem 0;
                border-right: 1px solid #ced4da;
                height: calc(100vh - 160px);
                display: -ms-flexbox;
                display: flex;
                -ms-flex-direction: column;
                flex-direction: column;
            }

                #chatframe #chatsidepanel #profile {
                    display: block;
                    width: 100%;
                    padding: 5px 15px;
                    background-color: #f6f7f8;
                }

                    #chatframe #chatsidepanel #profile .wrap {
                        height: 50px;
                        line-height: 50px;
                        overflow: hidden;
                        -moz-transition: 0.3s height ease;
                        -o-transition: 0.3s height ease;
                        -webkit-transition: 0.3s height ease;
                        transition: 0.3s height ease;
                    }

                        #chatframe #chatsidepanel #profile .wrap #profile-img {
                            width: 50px;
                            height: 50px;
                            border-radius: 50%;
                            padding: 3px;
                            border: 2px solid #337ab7;
                            float: left;
                            cursor: pointer;
                            -moz-transition: 0.3s border ease;
                            -o-transition: 0.3s border ease;
                            -webkit-transition: 0.3s border ease;
                            transition: 0.3s border ease;
                        }

                        #chatframe #chatsidepanel #profile .wrap p {
                            float: left;
                            margin-left: 15px;
                            line-height: 3.5em;
                            margin-bottom: 0px;
                        }

                        #chatframe #chatsidepanel #profile .wrap .creategroup {
                            float: right;
                            margin-top: 10px;
                            font-size: 0.8em;
                            cursor: pointer;
                            color: #8f181a;
                        }

                #chatframe #chatsidepanel #search {
                    display: block;
                    padding: 5px 15px;
                    border-top: 1px solid #ced4da;
                    border-bottom: 1px solid #ced4da;
                }

                    #chatframe #chatsidepanel #search input {
                        width: 100%;
                    }

                        #chatframe #chatsidepanel #search input:focus-visible {
                            outline: 0px;
                        }

                        #chatframe #chatsidepanel #search input::-webkit-input-placeholder {
                            color: #666666;
                        }

                        #chatframe #chatsidepanel #search input:-ms-input-placeholder {
                            color: #666666;
                        }

                        #chatframe #chatsidepanel #search input::placeholder {
                            color: #666666;
                        }

                        #chatframe #chatsidepanel #search input:focus {
                            background: #f0f2f5;
                            color: #666666;
                        }

                #chatframe #chatsidepanel #contacts ul {
                    padding: 0px;
                    list-style: none;
                }

                    #chatframe #chatsidepanel #contacts ul li.contact {
                        position: relative;
                        padding: 10px 0 10px 0;
                        font-size: 0.9em;
                        cursor: pointer;
                        border-bottom: 1px solid rgb(214 214 214 / 20%);
                    }

                        #chatframe #chatsidepanel #contacts ul li.contact:hover {
                            background-color: rgb(137 181 213 / 42%);
                            -webkit-transition: all 0.3s ease;
                            transition: all 0.3s ease;
                            border-bottom: 1px solid rgb(143 24 26 / 5%);
                        }

                        #chatframe #chatsidepanel #contacts ul li.contact.active {
                            color: #8f181a;
                            background-color: rgb(143 24 26 / 9%);
                            -webkit-transition: all 0.3s ease;
                            transition: all 0.3s ease;
                            border-bottom: 1px solid rgb(143 24 26 / 9%);
                        }

                        #chatframe #chatsidepanel #contacts ul li.contact .wrap {
                            width: 88%;
                            margin: 0 auto;
                            position: relative;
                        }

                            #chatframe #chatsidepanel #contacts ul li.contact .wrap .meta .name {
                                font-weight: 600;
                                text-transform: capitalize;
                                margin-bottom: 0px;
                                font-size: 13px;
                            }

                            #chatframe #chatsidepanel #contacts ul li.contact .wrap .meta {
                                padding: 5px 0 0 0;
                            }

                                #chatframe #chatsidepanel #contacts ul li.contact .wrap .meta .preview {
                                    margin: 5px 0 0 0;
                                    padding: 0 0 1px;
                                    font-weight: 400;
                                    white-space: nowrap;
                                    overflow: hidden;
                                    text-overflow: ellipsis;
                                    -moz-transition: 1s all ease;
                                    -o-transition: 1s all ease;
                                    -webkit-transition: 1s all ease;
                                    transition: 1s all ease;
                                }

            #chatframe .chatcontent {
            }

                #chatframe .chatcontent .chat-profile {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    flex-direction: row;
                    padding: 0.75rem 1rem;
                    border-bottom: 1px solid #ced4da;
                    -webkit-border-radius: 0 3px 0 0;
                    -moz-border-radius: 0 3px 0 0;
                    border-radius: 0 3px 0 0;
                }

        .chatcontent .chat-profile .active-user-info {
            display: flex;
            align-items: center;
        }

        #chatframe .chatcontent .chat-profile .profileimg {
            margin: 0 10px 0 0;
            width: 40px;
            height: 40px;
            -webkit-border-radius: 30px;
            -moz-border-radius: 30px;
            border-radius: 30px;
        }

        #chatframe .chatcontent .chat-profile h5 {
            font-size: .9rem;
        }

        #chatframe .chatcontent .chat-profile .right-option {
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: center;
        }

        #chatframe .chatcontent .messages {
            position: relative;
            padding: 1rem 1rem;
            height: calc(100vh - 290px);
        }

            #chatframe .chatcontent .messages ul {
                float: left;
                width: 100%;
                padding: 30px;
            }

                #chatframe .chatcontent .messages ul li {
                    display: inline-block;
                    clear: both;
                    float: left;
                    margin: 5px;
                    width: calc(100% - 25px);
                    font-size: 0.9em;
                }

                    #chatframe .chatcontent .messages ul li p {
                        display: inline-block;
                        max-width: 500px;
                        min-width: 200px;
                        padding: 10px 10px;
                        border-radius: 6px;
                        margin-bottom: 5px;
                        background: #f9f9f9;
                        box-shadow: 0 1px rgb(0 0 0 / 16%);
                    }

                    #chatframe .chatcontent .messages ul li.sent .name {
                        display: block;
                        font-weight: 600;
                        font-size: 11px;
                        margin-bottom: 2px;
                    }

                    #chatframe .chatcontent .messages ul li.sent .text {
                        display: block;
                    }

                    #chatframe .chatcontent .messages ul li.replies p {
                        float: right;
                        margin-bottom: 5px;
                        background-color: rgba(220, 247, 195, 0.67);
                    }

                    #chatframe .chatcontent .messages ul li.replies .name {
                        display: block;
                        font-weight: 600;
                        font-size: 11px;
                        margin-bottom: 2px;
                    }

                    #chatframe .chatcontent .messages ul li.replies .text {
                        display: block;
                    }

        #chatframe .chatcontent .message-input {
            position: relative;
            background: #f0f2f5;
            margin: 1rem -1rem 0rem;
            padding: 10px;
        }

            #chatframe .chatcontent .message-input .wrap {
                position: relative;
                text-align: center;
            }

                #chatframe .chatcontent .message-input .wrap input {
                    height: 45px;
                    background-color: #fff !important;
                }

                    #chatframe .chatcontent .message-input .wrap input:focus-visible {
                        outline: -webkit-focus-ring-color auto 0px;
                    }

                #chatframe .chatcontent .message-input .wrap .attachment {
                    position: absolute;
                    right: 60px;
                    z-index: 4;
                    margin-top: 10px;
                    font-size: 1.1em;
                    color: #8f181a;
                    opacity: .5;
                    cursor: pointer;
                }

                #chatframe .chatcontent .message-input .wrap .btn_Search {
                    display: flex;
                    width: 60px;
                    height: 44px;
                    margin-left: 0.3rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #ffffff;
                    background-color: #337ab7 !important;
                    border-color: #337ab7 !important;
                    border-bottom: 1px solid #337ab7;
                }

        .usersContainerScroll {
            height: 100%;
            overflow: hidden;
            overflow-y: scroll;
        }

            .usersContainerScroll::-webkit-scrollbar {
                width: 6px;
            }

            .usersContainerScroll::-webkit-scrollbar-track {
                background-color: #e4e4e4;
                border-radius: 100px;
            }

            .usersContainerScroll::-webkit-scrollbar-thumb {
                background-color: #1a7cc373;
                border-radius: 100px;
            }

        .chatContainerScroll {
            overflow: hidden;
            width: auto;
            height: 100%;
            overflow-y: scroll;
        }



            .chatContainerScroll::-webkit-scrollbar {
                width: 6px;
            }

            .chatContainerScroll::-webkit-scrollbar-track {
                background-color: #e4e4e4;
                border-radius: 100px;
            }

            .chatContainerScroll::-webkit-scrollbar-thumb {
                background-color: #1a7cc373;
                border-radius: 100px;
            }

        .no-gutters {
            margin-right: 0;
            margin-left: 0;
        }

            .no-gutters > .col, .no-gutters > [class*=col-] {
                padding-right: 0;
                padding-left: 0;
            }

        .highlight_stay {
            background-color: #1a7cc373;
        }


        @media screen and (min-width: 900px) {
        }

        @media screen and (min-width: 735px) {
            #chatframe .chatcontent .messages ul li p {
                max-width: 500px;
            }
        }

        .image-upload > input {
            display: none;
        }

        .image-upload img {
            cursor: pointer;
        }

        @media (max-width: 1600px) {
        }

        @media (max-width: 1440px) {
        }

        @media (max-width: 1366px) {
        }

        @media (max-width: 1280px) {
        }

        @media (max-width: 1024px) {
        }

        @media (max-width: 768px) {
        }

        @media (max-width: 576px) {
            #chatframe #chatsidepanel #profile .wrap #profile-img {
                display: none;
            }

            #chatframe #chatsidepanel #profile .wrap p {
                display: none;
            }

            #chatframe #chatsidepanel #search {
                display: none;
            }
        }
    </style>
    <%-- <script type="text/javascript" src="/Scripts/Fancy/source/jquery.fancybox.js"></script>
    <link rel="stylesheet" type="text/css" href="/Scripts/Fancy/source/jquery.fancybox.css" media="screen" />

    <!-- Add Button helper (this is optional) -->
    <link rel="stylesheet" type="text/css" href="/Scripts/Fancy/source/helpers/jquery.fancybox-buttons.css" />
    <script type="text/javascript" src="/Scripts/Fancy/source/helpers/jquery.fancybox-buttons.js"></script>

    <!-- Add Thumbnail helper (this is optional) -->
    <link rel="stylesheet" type="text/css" href="/Scripts/Fancy/source/helpers/jquery.fancybox-thumbs.css" />
    <script type="text/javascript" src="/Scripts/Fancy/source/helpers/jquery.fancybox-thumbs.js"></script>

    <!-- Add Media helper (this is optional) -->
    <script type="text/javascript" src="/Scripts/Fancy/source/helpers/jquery.fancybox-media.js"></script>

    <link href="/Scripts/jquery-ui.css" rel="stylesheet" />
    <script src="/Scripts/jquery-ui.js"></script>--%>

    <script src="/Scripts/jquery.signalR-2.2.2.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="/signalr/hubs" type="text/javascript"></script>


    <script type="text/javascript">
        var chkarray = [];
        let isActive = false;
        let mkadmin = false;

        $(function () {
            // Declare a proxy to reference the hub. 
            var chatHub = $.connection.chatHub;
            registerClientMethods(chatHub);
            // Start Hub
            $.connection.hub.start({ transport: 'longPolling' }).done(function () {
                registerEvents(chatHub)
            });
        });

        function registerEvents(chatHub) {

            var sid = '<%= this.UserCode %>';
            var name = '<%= this.UserName %>';

            if (name.length > 0) {
                chatHub.server.connect(sid, name);
            }

            $('#btnSendMsg').click(function () {
                var Message = $("#txtMessage").val();
                var TO_UserID = $('#hdtouserID').val();
                var typemessage = $('#hdChatMsgType').val();
                var filepath = '';
                var fromuserid = $('#hdConnectionUserId').val();

                if ($("#FileUploader").val() != '') {
                    if ($("#FileUploader")[0].files.length > 0) {

                        $.ajax({
                            url: 'UploadHandler.ashx',
                            type: 'POST',
                            data: new FormData($('form')[0]),
                            cache: false,
                            contentType: false,
                            processData: false
                        });

                        filepath = $("#FileUploader").val();
                        var fileNameIndex = filepath.lastIndexOf('\\') + 1;
                        var filename = filepath.substr(fileNameIndex);
                        Message = filename;
                        filepath = "Uploads/" + filename;
                    }
                }
                if (Message.length > 0) {

                    chatHub.server.sendMessageToAll(TO_UserID, fromuserid, Message, typemessage, filepath);

                    $("#txtMessage").val('');
                    $("#filnamespan").text('');
                    $("#FileUploader").val('');
                    //$('#hdtouserID').val('');
                    //$('#hdChatMsgType').val('');
                    $('#filnamespan').val('');
                    return false;
                }

            });

            $("#txtMessage").keypress(function (e) {
                if (e.which == 13) {
                    $('#btnSendMsg').click();
                    e.preventDefault();
                }
            });

            $("#txtsearchuser").keypress(function (e) {
                if (e.which == 13) { return false; }
            });


            // users selection for group
            $(document).on('change', 'input', function (e) {

                var idd = e.target.id;

                if (idd.startsWith("chk_")) {
                    if ($(`#${idd}`).is(':checked')) {
                        isActive = true;
                        var idaftersplit = idd.split("_")[1];
                        chkarray.push(idaftersplit);
                    }
                    else {
                        chkarray.splice($.inArray(idaftersplit, chkarray), 1);
                    }
                }

                if (idd.startsWith("makeadminchk_")) {
                    if ($(`#${idd}`).is(':checked')) {
                        $('.RemoveMember').prop('checked', false);
                        $('.AddMember').prop('checked', false);

                        isActive = true;
                        mkadmin = true;
                        var idaftersplit = idd.split("_")[1];
                        chkarray.push(idaftersplit);
                    }
                    else {
                        isActive = true;
                        mkadmin = false;
                        var idaftersplit = idd.split("_")[1];
                        chkarray.push(idaftersplit);
                        //chkarray.splice($.inArray(idaftersplit, chkarray), 1);
                    }
                }

                if (idd.startsWith("delchk_")) {
                    if ($(`#${idd}`).is(':checked')) {
                        $('.makeMemberadmin').prop('checked', false);
                        $('.AddMember').prop('checked', false);

                        var idaftersplit = idd.split("_")[1];
                        isActive = false;
                        mkadmin = false;
                        chkarray.push(idaftersplit);
                    }
                    else {
                        chkarray.splice($.inArray(idaftersplit, chkarray), 1);
                    }
                }

                if (idd.startsWith("addchk_")) {
                    if ($(`#${idd}`).is(':checked')) {
                        $('.RemoveMember').prop('checked', false);
                        $('.makeMemberadmin').prop('checked', false);

                        var idaftersplit = idd.split("_")[1];
                        isActive = true; mkadmin = false;
                        chkarray.push(idaftersplit);
                    }
                    else {
                        chkarray.splice($.inArray(idaftersplit, chkarray), 1);
                    }
                }

                if (idd == "FileUploader") {

                    var filepath = $(`#${idd}`).val();;
                    var fileNameIndex = filepath.lastIndexOf('\\') + 1;
                    var filename = filepath.substr(fileNameIndex);
                    $("#filnamespan").text(filename);
                }
            });

            // To Create New Group
            $('#btnCreateGroup').click(function () {
                debugger
                if ($('#txtgroupname').val() == '') { AlertBox('Notify', 'Please Enter Group Name', 'info'); return false; }
                mkadmin = false;
                var fromuserid = $('#hdConnectionUserId').val();
                var d = new Date();
                // var year = d.getFullYear();
                var month = d.getMonth() + 1;
                var day = d.getDate();
                var hour = d.getHours();
                //  var minute = d.getMinutes();
                var second = d.getSeconds();
                var milisecond = d.getMilliseconds();

                var GroupID = '' + day + hour + second + milisecond;
                var GroupName = $('#txtgroupname').val();
                chkarray.push(fromuserid);
                var GroupMembers = chkarray;
                var GroupCreatedBy = fromuserid;
                var GroupAdmin = fromuserid;
                var _isActive = 0;
                if (isActive == true) {
                    _isActive = 1;
                }
                else {
                    _isActive = 0;
                }


                $.ajax({
                    type: "POST",
                    url: 'WebService/ChatApplication.asmx/CreateGroup',
                    data: JSON.stringify({ "GroupID": GroupID, "GroupName": GroupName, "GroupMembers": GroupMembers, "GroupCreatedBy": fromuserid, "GroupAdmin": GroupAdmin, "isActive": _isActive }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var result = jQuery.parseJSON(data.d);
                        if (result.length !== 0) {
                            $('#tbl_list').empty();
                            for (i = 0; i < result.length; i++) {
                                AddList(result[i].User_Code, result[i].Full_Name, result[i].DepartmentName);
                            }
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                        AlertBox('Error', 'Error has occurred..', 'error');
                    }
                });

                $('#creategroup').modal('hide');
                $('body').removeClass('modal-open');
                $('.modal-backdrop').remove();
                $('.Userlist').prop('checked', false);
                $("#txtsearchuser").val('');
                $("#txtgroupname").val('');
                chkarray = [];
                isActive = false;
                mkadmin = false;

            });

            //to delete group / leave group   
            $('#btnDelete').click(function () {

                var fromuserid = $('#hdConnectionUserId').val();
                var GroupName = $('#txtgroupname').val();
                var groupid = $('#hdtouserID').val();

                $.ajax({
                    type: "POST",
                    url: 'WebService/ChatApplication.asmx/DeleteGroup',
                    data: JSON.stringify({ "GroupID": groupid, "GroupName": GroupName, "GroupMembers": fromuserid }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        ;
                        var result = jQuery.parseJSON(data.d.split('---')[0]);
                        var result2 = jQuery.parseJSON(data.d.split('---')[1]);
                        var result3 = jQuery.parseJSON(data.d.split('---')[2]);

                        if (result.length !== 0) {
                            $('#tbl_list').empty();
                            for (i = 0; i < result.length; i++) {
                                var isActive = result[i].isActive;
                                if (isActive == 0) {
                                    $('#chatbodyfooter').hide();
                                }
                            }
                        }

                        if (result2.length !== 0) {
                            $('#tbl_list').empty();
                            for (i = 0; i < result2.length; i++) {
                                AddList(result2[i].User_Code, result2[i].Full_Name, result2[i].DepartmentName);
                            }
                        }

                        if (result3.length !== 0) {
                            for (i = 0; i < result3.length; i++) {
                                var isActive = result3[i].isActive;
                                if (isActive == 0) {
                                    $('#chatbodyfooter').hide();
                                }
                            }
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                        AlertBox('Error', 'Error has occurred..', 'error');
                    }
                });

                ClosePopupmyModal();

            });

            //for binding members of groups
            $('#img_grp').click(function () {

                var groupid = $('#hdtouserID').val();
                var currentuser = $('#hdConnectionUserId').val();

                $.ajax({
                    type: "POST",
                    url: 'WebService/ChatApplication.asmx/GetAllMembersofGroup',
                    data: JSON.stringify({ "GroupID": groupid, "CurrentUser": currentuser }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var result = jQuery.parseJSON(data.d.split('---')[0]);
                        var result2 = jQuery.parseJSON(data.d.split('---')[1]);

                        if (result2.length !== 0) {
                            for (var i = 0; i < result2.length; i++) {

                                var User_Code = result2[i].User_Code;
                                var Full_Name = result2[i].Full_Name;
                                var DepartmentName = result2[i].DepartmentName;

                                var tbl_addgrpmemberlist = '';

                                tbl_addgrpmemberlist += '<tr>';
                                tbl_addgrpmemberlist += '<td style="text-align: center;display:none" class="td_AddMember">';
                                tbl_addgrpmemberlist += '<input class="AddMember" type="checkbox" name="AddMember" id="addchk_' + User_Code + '" />';
                                tbl_addgrpmemberlist += '</td>';
                                tbl_addgrpmemberlist += '<td style="text-align: left;">';
                                tbl_addgrpmemberlist += '<div style="font-weight:bold;">' + Full_Name + '</div>';
                                tbl_addgrpmemberlist += '<div style="text-align: left;font-size: 8px;">';
                                tbl_addgrpmemberlist += DepartmentName
                                tbl_addgrpmemberlist += '</div>';
                                tbl_addgrpmemberlist += '</td>';
                                tbl_addgrpmemberlist += '</tr>';
                                $('#tbl_addgrpmemberlist').append(tbl_addgrpmemberlist);

                            }
                        }

                        if (result.length !== 0) {
                            for (var i = 0; i < result.length; i++) {

                                var GroupMemberID = result[i].GroupMemberID;
                                var GroupMemberName = result[i].GroupMemberName;
                                var GroupName = result[i].GroupName;
                                var GroupAdmin = result[i].GroupAdmin;
                                var isActive = result[i].isActive;

                                $("#txtgroupname").val(GroupName);
                                var tbl_list_group = '';
                                tbl_list_group += '<tr>';
                                tbl_list_group += '<td style="text-align:center;display:none" class="td_remove">';
                                tbl_list_group += 'Remove</label><input class="RemoveMember" type="checkbox" name="RemoveMember" id="delchk_' + GroupMemberID + '" />';
                                tbl_list_group += '</td>';
                                tbl_list_group += '<td style="text-align: left;">';
                                tbl_list_group += '<div style="font-weight:bold;">' + GroupMemberName + '</div>';
                                tbl_list_group += '<div style="text-align: left;font-size: 8px;">';
                                tbl_list_group += GroupName
                                tbl_list_group += '</div>';
                                tbl_list_group += '</td>';

                                tbl_list_group += '<td style="text-align:center;display:none" class="td_makeadmin">';
                                tbl_list_group += 'Make Admin</label><input class="makeMemberadmin" type="checkbox" name="makeMemberadmin" id="makeadminchk_' + GroupMemberID + '" />';
                                tbl_list_group += '</td>';

                                tbl_list_group += '</tr>';
                                $('#tbl_grpmemberlist').append(tbl_list_group);
                                if (GroupMemberID == GroupAdmin) {
                                    $(`#makeadminchk_${GroupMemberID}`).prop('checked', true);
                                }
                            }
                        }

                        //////////////////////////////////////////
                        $.ajax({
                            type: "POST",
                            url: 'WebService/ChatApplication.asmx/GetAdmiin',
                            data: JSON.stringify({ "GroupID": groupid, "CurrentUser": currentuser }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var result3 = jQuery.parseJSON(data.d);
                                ;
                                if (result3.length !== 0) {
                                    for (var i = 0; i < result3.length; i++) {
                                        var GroupMemberID = result3[i].GroupMembers;
                                        var GroupAdmin = result3[i].GroupAdmin;

                                        if (currentuser == GroupAdmin && GroupMemberID == currentuser) {
                                            //  $(`#makeadminchk_${GroupMemberID}`).prop('checked', true);
                                            $('.td_AddMember').show();
                                            $('.td_remove').show();
                                            $('.td_makeadmin').show();
                                        }
                                    }
                                }

                            },
                            error: function (xhr) {
                                console.log(xhr.responseText);
                                AlertBox('Error', 'Error has occurred..', 'error');
                            }
                        });

                        /////////////////////////////////////////

                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                        AlertBox('Error', 'Error has occurred..', 'error');
                    }
                });

            });

            //for updating group information
            $('#btnSave').click(function () {
                debugger
                var fromuserid = $('#hdConnectionUserId').val();
                var GroupID = $('#hdtouserID').val();
                var GroupName = $('#txtgroupname').val();
                var GroupCreatedBy = 0, GroupAdmin = 0;


                if (mkadmin == true) {
                    GroupAdmin = 1;
                }
                else {
                    GroupAdmin = 0;
                }

                var _isActive = 0;
                if (isActive == true) {
                    _isActive = 1;
                }
                else {
                    _isActive = 0;
                }
                var GroupMembers = chkarray;


                $.ajax({
                    type: "POST",
                    url: 'WebService/ChatApplication.asmx/CreateGroup',
                    data: JSON.stringify({ "GroupID": GroupID, "GroupName": GroupName, "GroupMembers": GroupMembers, "GroupCreatedBy": GroupCreatedBy, "GroupAdmin": GroupAdmin, "isActive": _isActive }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var result = jQuery.parseJSON(data.d);
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                        AlertBox('Error', 'Error has occurred..', 'error');
                    }
                });

                ClosePopupmyModal();
            });

            //for hidding memberlist
            $('#td_AddUser').click(function () {
                $('#tbl_addgrpmemberlist').show();

                chkarray = [];
                isActive = false;
                mkadmin = false;

                $('#tbl_grpmemberlist').hide();
                return false;
            });

            //for hidding users to add in memberlist
            $('#td_DeleteUser').click(function () {
                $('#tbl_grpmemberlist').show();

                chkarray = [];
                isActive = false;
                mkadmin = false;

                $('#tbl_addgrpmemberlist').hide();
                return false;
            });

        }

        function registerClientMethods(chatHub) {

            // Calls when user successfully logged in
            chatHub.client.onConnected = function (ConnectionUserId, ConnectionUserName, DepartmentName, AllGroupandUserlist) {

                $('#hdConnectionUserId').val(ConnectionUserId);
                $('#hdConnectionUserName').val(ConnectionUserName);
                $('#loginusername').text(ConnectionUserName);

                // Add All Users
                for (i = 0; i < AllGroupandUserlist.length; i++) {
                    AddList(AllGroupandUserlist[i].ConnectionId, AllGroupandUserlist[i].UserName, AllGroupandUserlist[i].DepartmentName);
                }
            }

            // On New User Connected
            chatHub.client.onNewUserConnected = function (ConnectionUserId, ConnectionUserName, AllGroupandUserlist, UserImage, loginDate) {
                // AddUser(chatHub, ConnectionUserId, ConnectionUserName, AllGroupandUserlist, loginDate);
            }

            // On User Disconnected
            //chatHub.client.onUserDisconnected = function (id, userName) {
            chatHub.client.onUserDisconnected = function (Message, id) {

                setTimeout(function () {
                    $.connection.hub.start();
                }, 1000); // Restart connection after 5 seconds.

                if ($.connection.hub.lastError) { AlertBox('Notify', 'Disconnected. Reason: ' + $.connection.hub.lastError.message, 'info'); }



                //$('#Div' + id).remove();
                //var ctrId = 'private_' + id;
                //$('#' + ctrId).remove();
                //var disc = $('<div class="disconnect">"' + userName + '" logged off.</div>');
                //$(disc).hide();
                //$('#divusers').prepend(disc);
                //$(disc).fadeIn(200).delay(2000).fadeOut(200);
            }

            // On Message Recieved
            chatHub.client.messageReceived = function (TO_UserID, To_User_Name, From_User_ID, From_User_Name, Chat_Messages, Chat_DateTime, typemessage, file_path, GroupID, GroupName) {
                debugger
                var ConnectedUserID = $('#hdConnectionUserId').val();
                if (typemessage == 'Group') {
                    var chk = $('#hdtouserID').val();
                    if (ConnectedUserID == TO_UserID && GroupID != 0) {
                        if ($("#tbl_chats").css('display') != 'block') {
                            //openchatmessageGroup(TO_UserID, From_User_ID, GroupID, GroupName, 'Group', typemessage);

                            $('#img_grp').show();
                            $('#span9').show();

                            $('#tbl_chats').css('display', 'block');
                            var ConnectedUserID = $('#hdConnectionUserId').val();
                            var ListID = GroupID;
                            $('#hdtouserID').val(ListID);
                            $('#tbl_chats').empty();
                            $("#lbl_chatbodyheadername").text(GroupName);
                            $('#hdChatMsgType').val(typemessage);

                            $.ajax({
                                type: "POST",
                                url: 'WebService/ChatApplication.asmx/GetAllMessagesOnselectedGroup',
                                data: JSON.stringify({ "ToUserID": TO_UserID, "FromUserID": From_User_ID, "GroupID": GroupID, "typemessage": typemessage }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    var result = jQuery.parseJSON(data.d);
                                    if (result.length !== 0) {
                                        for (var i = 0; i < result.length; i++) {

                                            var To_User_ID = result[i].To_User_ID;
                                            var To_User_Name = result[i].To_User_Name;

                                            var From_User_ID = result[i].From_User_ID;
                                            var From_User_Name = result[i].From_User_Name;

                                            var Chat_Messages = result[i].Chat_Messages;
                                            var Chat_DateTime = result[i].Chat_DateTime;
                                            var file_path = result[i].file_path;

                                            var Side = 'sent';
                                            var TimeSide = 'right';
                                            if (ConnectedUserID == From_User_ID) {
                                                Side = 'replies';
                                                TimeSide = 'left';
                                            }

                                            var tbl_chats = '';
                                            tbl_chats += '<li class="' + Side + '">';
                                            tbl_chats += '<p>';
                                            tbl_chats += '<span class="name">' + From_User_Name;
                                            //tbl_chats += ' <span style="font-size: 10px;">(' + ListDepartmentName + ')</span>';
                                            tbl_chats += '</span>';
                                            // Chat messages here
                                            tbl_chats += '<span class="text">';
                                            if (file_path != '') {
                                                tbl_chats += '<a class="icon-download" href="' + file_path + '" target="' + file_path + '" download>' + Chat_Messages + '</a>';
                                            }
                                            else { tbl_chats += Chat_Messages; }
                                            tbl_chats += '</span>';
                                            tbl_chats += '</p>';
                                            // End Chat messages here
                                            tbl_chats += '</li>';
                                            $('#tbl_chats').append(tbl_chats);
                                            //$('#chatbodybottom').scrollTop(1000);
                                            $('#chatbodybottom').scrollTop($("#chatbodybottom")[0].scrollHeight);
                                        }
                                    }
                                },
                                error: function (xhr) {
                                    console.log(xhr.responseText);
                                    AlertBox('Error', 'Error has occurred..', 'error');
                                }
                            });

                        }
                        else {
                            if ($("#lbl_chatbodyheadername").text() != 'Irfan' && $("#lbl_chatbodyheadername").text() == GroupName) {
                                var Side = 'sent';
                                var TimeSide = 'right';
                                if (ConnectedUserID == From_User_ID && ConnectedUserID == TO_UserID) {
                                    Side = 'replies';
                                    TimeSide = 'left';
                                }
                                var tbl_chats = '';
                                tbl_chats += '<li class="' + Side + '">';
                                tbl_chats += '<p>';
                                tbl_chats += '<span class="name">' + From_User_Name;
                                //tbl_chats += ' <span style="font-size: 10px;">(' + ListDepartmentName + ')</span>';
                                tbl_chats += '</span>';
                                // Chat messages here
                                tbl_chats += '<span class="text">';
                                // tbl_chats += Chat_Messages
                                if (file_path != '') {
                                    tbl_chats += '<a class="icon-download" href="' + file_path + '" target="' + file_path + '" download>' + Chat_Messages + '</a>';
                                }
                                else { tbl_chats += Chat_Messages; }
                                tbl_chats += '</span>';
                                tbl_chats += '</p>';
                                // End Chat messages here
                                tbl_chats += '</li>';

                                $('#tbl_chats').append(tbl_chats);
                                //$('#chatbodybottom').scrollTop(1000);
                                $('#chatbodybottom').scrollTop($("#chatbodybottom")[0].scrollHeight);
                                $('#hdtouserID').val(GroupID);
                            }
                            else {

                                if (ConnectedUserID != From_User_ID && ConnectedUserID == TO_UserID) {
                                    AlertBox('Notify', 'Message Recieved From ' + From_User_Name + ' In Group => ' + GroupName, 'info');
                                }

                            }
                        }
                    }

                }
                else {

                    //reciever to other user id
                    if (ConnectedUserID != From_User_ID && ConnectedUserID == TO_UserID && GroupID == 0) {

                        if ($("#tbl_chats").css('display') != 'block') {
                            openchatmessage(From_User_ID, From_User_Name, '', typemessage);
                        }
                        else {
                            debugger
                            if ($("#lbl_chatbodyheadername").text().trim() == From_User_Name) {

                                var Side = 'sent';
                                var TimeSide = 'right';
                                if (ConnectedUserID == From_User_ID) {
                                    Side = 'replies';
                                    TimeSide = 'left';
                                }
                                var tbl_chats = '';
                                tbl_chats += '<li class="' + Side + '">';
                                tbl_chats += '<p>';
                                tbl_chats += '<span class="name">' + From_User_Name;
                                //tbl_chats += ' <span style="font-size: 10px;">(' + ListDepartmentName + ')</span>';
                                tbl_chats += '</span>';
                                // Chat messages here
                                tbl_chats += '<span class="text">';
                                //tbl_chats += Chat_Messages
                                if (file_path != '') {
                                    tbl_chats += '<a class="icon-download" href="' + file_path + '" target="' + file_path + '" download>' + Chat_Messages + '</a>';
                                }
                                else { tbl_chats += Chat_Messages; }
                                tbl_chats += '</span>';
                                tbl_chats += '</p>';
                                // End Chat messages here
                                tbl_chats += '</li>';

                                $('#tbl_chats').append(tbl_chats);
                                //$('#chatbodybottom').scrollTop(1000);
                                $('#chatbodybottom').scrollTop($("#chatbodybottom")[0].scrollHeight);
                                //$('#hdtouserID').val(ListID);
                            }
                            else {
                                if (ConnectedUserID != From_User_ID && ConnectedUserID == TO_UserID) {
                                    AlertBox('Notify', 'Message Recieved From => ' + From_User_Name, 'info');
                                }
                            }
                        }
                    }

                    //reciever to same user id
                    if (ConnectedUserID == From_User_ID && ConnectedUserID != TO_UserID && From_User_ID != TO_UserID) {
                        var Side = 'sent';
                        var TimeSide = 'right';
                        if (ConnectedUserID == From_User_ID) {
                            Side = 'replies';
                            TimeSide = 'left';
                        }
                        var tbl_chats = '';
                        tbl_chats += '<li class="' + Side + '">';
                        tbl_chats += '<p>';
                        tbl_chats += '<span class="name">' + From_User_Name;
                        //tbl_chats += ' <span style="font-size: 10px;">(' + ListDepartmentName + ')</span>';
                        tbl_chats += '</span>';
                        // Chat messages here
                        tbl_chats += '<span class="text">';
                        if (file_path != '') {
                            tbl_chats += '<a class="icon-download" href="' + file_path + '" target="' + file_path + '" download>' + Chat_Messages + '</a>';
                        }
                        else { tbl_chats += Chat_Messages; }
                        tbl_chats += '</span>';
                        // End Chat messages here
                        tbl_chats += '</p>';
                        tbl_chats += '</li>';

                        $('#tbl_chats').append(tbl_chats);
                        //$('#chatbodybottom').scrollTop(1000);
                        $('#chatbodybottom').scrollTop($("#chatbodybottom")[0].scrollHeight);
                        //$('#tbl_chats').css('display', 'block'); 
                    }
                }
            }
        }

        // for Opening Chat Message
        function openchatmessage(ListID, ListName, ListDepartmentName, typemessage) {
            $('#span9').show();
            debugger
            $('li').removeClass('highlight_stay');
            $('#' + ListID ).addClass('highlight_stay');
            $('#tbl_chats').css('display', 'block');
            var ConnectedUserID = $('#hdConnectionUserId').val();
            var ListID = ListID;
            $('#hdtouserID').val(ListID);
            $('#tbl_chats').empty();
            $("#lbl_chatbodyheadername").text(ListName);

            if (ListDepartmentName == 'Group') {
                $('#hdChatMsgType').val('Group');
                $('#img_grp').show();
            }
            else { $('#hdChatMsgType').val('Single'); $('#img_grp').hide(); }
            typemessage = $('#hdChatMsgType').val();

            if (ListDepartmentName == 'Group') {
                openchatmessagegroup('', ConnectedUserID, ListID, ListName, ListDepartmentName, typemessage);
            }
            else {
                $.ajax({
                    type: "POST",
                    url: 'WebService/ChatApplication.asmx/GetAllMessagesOnselecteduser',
                    data: JSON.stringify({ "ConnectedUserID": ConnectedUserID, "ToUserID": ListID, "typemessage": typemessage }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var result = jQuery.parseJSON(data.d);
                        if (result.length !== 0) {
                            for (var i = 0; i < result.length; i++) {

                                var To_User_ID = result[i].To_User_ID;
                                var To_User_Name = result[i].To_User_Name;
                                var From_User_ID = result[i].From_User_ID;
                                var From_User_Name = result[i].From_User_Name;
                                var Chat_Messages = result[i].Chat_Messages;
                                var Chat_DateTime = result[i].Chat_DateTime;
                                var file_path = result[i].file_path;

                                var Side = 'sent';
                                var TimeSide = 'right';
                                if (ConnectedUserID == From_User_ID) {
                                    Side = 'replies';
                                    TimeSide = 'left';
                                }

                                var tbl_chats = '';
                                tbl_chats += '<li class="' + Side + '">';
                                // tbl_chats += '<p style="text-align: ' + sideleft + ';">' + From_User_Name;
                                tbl_chats += '<p>';
                                tbl_chats += '<span class="name">' + From_User_Name;
                                //tbl_chats += ' <span style="font-size: 10px;">(' + ListDepartmentName + ')</span>';
                                tbl_chats += '</span>';
                                // Chat messages here
                                tbl_chats += '<span class="text">';
                                // tbl_chats += Chat_Messages;
                                if (file_path != '') {
                                    tbl_chats += '<a class="icon-download" href="' + file_path + '" target="' + file_path + '" download>' + Chat_Messages + '</a>';
                                }
                                else { tbl_chats += Chat_Messages; }
                                tbl_chats += '</span>';
                                tbl_chats += '</p>';
                                // End Chat messages here
                                tbl_chats += '</li>';
                                $('#tbl_chats').append(tbl_chats);
                                //$('#chatbodybottom').scrollTop(1000);
                                $('#chatbodybottom').scrollTop($("#chatbodybottom")[0].scrollHeight);
                            }
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                        AlertBox('Error', 'Error has occurred..', 'error');
                    }
                });
            }
        }

        // for Opening Chat Messages for Group
        function openchatmessagegroup(touserid, fromuserid, ListID, ListName, ListDepartmentName, typemessage) {
            debugger
            $('#img_grp').show();
            if (touserid == '') { touserid = ListID; }
            $('#span9').show();

            $('#tbl_chats').css('display', 'block');
            var ConnectedUserID = $('#hdConnectionUserId').val();
            var ListID = ListID;
            $('#hdtouserID').val(ListID);
            $('#tbl_chats').empty();
            $("#lbl_chatbodyheadername").text(ListName);

            if (ListDepartmentName == 'Group') {
                $('#hdChatMsgType').val('Group');
            }
            typemessage = $('#hdChatMsgType').val();

            $.ajax({
                type: "POST",
                url: 'WebService/ChatApplication.asmx/GetAllMessagesOnselectedGroup',
                data: JSON.stringify({ "ToUserID": touserid, "FromUserID": fromuserid, "GroupID": ListID, "typemessage": typemessage }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var result = jQuery.parseJSON(data.d.split('---')[0]);
                    var result3 = jQuery.parseJSON(data.d.split('---')[1]);
                    debugger
                    if (result.length !== 0) {
                        for (var i = 0; i < result.length; i++) {
                            var To_User_ID = result[i].To_User_ID;
                            var To_User_Name = result[i].To_User_Name;

                            var From_User_ID = result[i].From_User_ID;
                            var From_User_Name = result[i].From_User_Name;

                            var Chat_Messages = result[i].Chat_Messages;
                            var Chat_DateTime = result[i].Chat_DateTime;
                            var file_path = result[i].file_path;
                            var isActive = result[i].isActive;

                            var Side = 'sent';
                            var TimeSide = 'right';
                            if (ConnectedUserID == From_User_ID) {
                                Side = 'replies';
                                TimeSide = 'left';
                            }

                            var tbl_chats = '';
                            tbl_chats += '<li class="' + Side + '">';
                            tbl_chats += '<p>';
                            tbl_chats += '<span class="name">' + From_User_Name;
                            //tbl_chats += ' <span style="font-size: 10px;">(' + ListDepartmentName + ')</span>';
                            tbl_chats += '</span>';
                            // Chat messages here
                            tbl_chats += '<span class="text">';
                            if (file_path != '') {
                                tbl_chats += '<a class="icon-download" href="' + file_path + '" target="' + file_path + '" download>' + Chat_Messages + '</a>';
                            }
                            else { tbl_chats += Chat_Messages; }
                            tbl_chats += '</span>';
                            // End Chat messages here
                            tbl_chats += '</p>';
                            tbl_chats += '</li>';
                            $('#tbl_chats').append(tbl_chats);
                            //$('#chatbodybottom').scrollTop(1000);
                            $('#chatbodybottom').scrollTop($("#chatbodybottom")[0].scrollHeight);

                            if (isActive == false) {
                                $('#chatbodyfooter').hide();
                            }
                        }
                    }

                    if (result3.length !== 0) {
                        for (i = 0; i < result3.length; i++) {
                            var isActive = result3[i].isActive;
                            if (isActive == false) {
                                $('#chatbodyfooter').hide();
                            }
                            else {
                                $('#chatbodyfooter').show();
                            }
                        }
                        return false;
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                    AlertBox('Error', 'Error has occurred..', 'error');
                }
            });
        }

        // list of all users and groups in left side panel
        function AddList(ListID, ListName, ListDepartmentName) {
            debugger
            var typemessage = '';
            if (ListDepartmentName !== 'Group') { typemessage = 'Single' }
            else { typemessage = 'Group' }


            var tbl_list = '';
            tbl_list += '<li class="contact" onclick="openchatmessage(' + "'" + ListID + "'" + "," + "'" + ListName + "'" + "," + "'" + typemessage + "'" + ');"  id="' + ListID +'">';
            tbl_list += '<div class="wrap">';
            tbl_list += '<div class="meta">';
            tbl_list += '<p class="name">';
            tbl_list += typemessage == 'Group' ? '<i class="fa fa-users"></i> ' : '<i class="fa fa-user"></i> ';
            tbl_list += ListName + '</p>';
            tbl_list += '</div>';
            tbl_list += '</div>';
            tbl_list += '</li>';
            $('#tbl_list').append(tbl_list);


            // for binding users for creating group  
            if (ListDepartmentName != 'Group') {
                var tbl_list_group = '';
                tbl_list_group += '<tr>';
                tbl_list_group += '<td style="text-align: center;">';
                tbl_list_group += '<input class="Userlist" type="checkbox" name="Userlist" id="chk_' + ListID + '" />';
                tbl_list_group += '</td>';
                tbl_list_group += '<td style="text-align: left;">';
                tbl_list_group += '<div style="font-weight:bold;">' + ListName + '</div>';
                tbl_list_group += '</td>';
                tbl_list_group += '</tr>';
                $('#tbl_creategroup').append(tbl_list_group);
            }
        }

        // for searching users or group in chat messages
        function listsearch(txtid, tblid) {
            // Declare variables
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById(txtid);
            filter = input.value.toUpperCase();
            table = document.getElementById(tblid);
            tr = table.getElementsByTagName("li");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                // td = tr[i].getElementsByTagName("td")[0];
                // if (td) {
                txtValue = tr[i].textContent || tr[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
                // }
            }
        }

        // for searching of users for making group
        function modalsearch(txtid, tblid) {
            // Declare variables
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById(txtid);
            filter = input.value.toUpperCase();
            table = document.getElementById(tblid);
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[1];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="container-fluid">
                <input id="hdConnectionUserId" type="hidden" />
                <input id="hdConnectionUserName" type="hidden" />
                <input id="hdtouserID" type="hidden" />
                <input id="hdChatMsgType" type="hidden" />

                <div id="chatframe">
                    <div class="row no-gutters">
                        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-4 col-3">
                            <div id="chatsidepanel">
                                <div id="profile">
                                    <div class="wrap">
                                        <img id="profile-img" src="../Assets/Images/UserImage.png" />
                                        <p>
                                            <label id="loginusername" style="text-transform: capitalize; font-weight: 600;"></label>
                                        </p>
                                        <img src="../Assets/Images/Status/new-group.png" class="creategroup btn_AddItem1" data-toggle="modal" data-target="#creategroup" alt="" />
                                    </div>
                                </div>
                                <div id="search">
                                    <input type="text" id="txtsearch" class="form-control Search EnterEvent span12" placeholder="Search Chat" onkeyup="listsearch(this.id,'tbl_list')" />
                                </div>
                                <div id="contacts" class="usersContainerScroll">
                                    <ul id="tbl_list">
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-9 col-lg-8 col-md-8 col-sm-8 col-9">
                            <%-- for chat messages --%>
                            <div class="chatcontent">
                                <div id="span9" style="display: none;">
                                    <div id="chatbodyheader" class="chat-profile">
                                        <div class="active-user-info">
                                            <img class="profileimg" src="../Assets/Images/UserImage.png" />
                                            <h5>
                                                <label id="lbl_chatbodyheadername" style="text-transform: capitalize; font-weight: 600;">Irfan</label></h5>
                                        </div>
                                        <div class="right-option">
                                            <img id="img_grp" src="../Assets/Images/Status/Icons/setting.png" style="display: none" class="myModal btn_AddItem" data-toggle="modal" data-target="#myModal" />
                                        </div>
                                    </div>
                                    <div class="messages" id="chatbodybottom">
                                        <div class="chatContainerScroll">
                                            <ul id="tbl_chats">
                                            </ul>
                                        </div>
                                        <div id="chatbodyfooter" class="message-input">
                                            <div class="wrap d-flex">
                                                <%-- <a class="btn image-upload">
                                        <label for="file-input">
                                            <img src="/Images/Status/Icons/file-upload.png" title="Upload File" />
                                        </label>
                                    <input type="file" id="FileUploader" name="FileUploader" />

                                    </a>--%>
                                                <label class="file-upload">
                                                    <i class="fa fa-upload" aria-hidden="true" style="font-size: 18px; color: #54656f; display: flex;">
                                                        <input type="file" id="FileUploader" name="FileUploader" style="width: 5px; height: 5px">
                                                    </i>
                                                </label>
                                                <label id="filnamespan" style="font-size: 10px; margin-top: 12px; margin-right: 5px;"></label>
                                                <input type="text" id="txtMessage" class="form-control" placeholder="Type a message" />
                                                <%-- 
                                    <div class="icon-upload-icon">
                                        <i class="icon-upload attachment" aria-hidden="true">
                                            <input type="file" id="FileUploader" name="FileUploader" />
                                        </i>
                                    </div>--%>
                                                <input type="button" class="btn btn-primary btn_Search" id="btnSendMsg" value="Send" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


    <%-- Modals --%>

    <%-- To Create Group --%>
    <div id="creategroup" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-dialog-centered justify-content-center">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-body">
                            <div>
                                <table style="width: 100%; border: 0px">
                                    <tr style="width: 100%">
                                        <td style="text-align: left; width: 35%">
                                            <h5>Create Group</h5>
                                        </td>
                                        <td style="text-align: right; width: 65%">
                                            <input type="button" class="btn btn-primary btn-sm btn_Search" id="btnCreateGroup" value="Create Group" />
                                            <asp:Button runat="server" data-bs-dismiss="modal" ID="btn_Close" Text="Close" class="btn btn-default btn-sm" OnClientClick="ClosePopupcreategroup();return false;"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-5 mb-2">
                                <table style="width: 100%; border: 0px">
                                    <tr style="width: 100%">
                                        <td style="text-align: center; width: 50%">
                                            <input type="text" class="form-control" id="txtsearchuser" placeholder="Type to Search ..." onkeyup="modalsearch(this.id, 'tbl_creategroup')" />
                                        </td>
                                        <td style="text-align: center; width: 50%">
                                            <input type="text" class="form-control" id="txtgroupname" placeholder="Group Name" required />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="board-widgets-head clearfix creating-group">
                                <table id="tbl_creategroup" class="table table-bordered table-sm" style="border: 0px">
                                </table>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <%-- For Setting --%>
    <div id="myModal" class="modal fade" role="dialog" data-keyboard="false" fv="static">
        <div class="modal-dialog">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <!-- Modal content-->
                    <div class="modal-content">

                        <div class="modal-body">

                            <div class="row pb-5" style="border-bottom: 1px solid #ccc;">
                                <div class="col-lg-4">
                                    <h5>Settings</h5>
                                </div>
                                <div class="col-lg-8 text-right">
                                    <input type="button" class="btn btn-primary btn-sm btn_Search" id="btnDelete" value="Leave Group" />
                                </div>
                            </div>

                            <div class="clearfix mt-5">
                                <div class="row">
                                    <div class="col-lg-6 d-grid">
                                        <button id="td_DeleteUser" class="btn btn-primary btn_Search AddMember btn-sm">Group Members</button>
                                    </div>
                                    <div class="col-lg-6 d-grid text-right">
                                        <button class="btn btn-primary btn_Search btn-sm" id="td_AddUser">
                                            Add User
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <%--<div class="clearfix" style="height: 341px; overflow-y: scroll; padding: 2px;">--%>
                            <div class="board-widgets-head clearfix" style="border: 1px solid #ccc; height: 341px; overflow-y: scroll">
                                <table id="tbl_grpmemberlist" class="table table-bordered table-sm" style="border: 0px">
                                </table>
                                <table id="tbl_addgrpmemberlist" style="display: none; border: 0px" class="table table-bordered table-sm">
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer" style="padding-bottom: 10px; padding-top: 0;">
                            <input type="button" class="btn btn-primary btn-sm btn_Search" id="btnSave" value="Save" />
                            <asp:Button runat="server" ID="btn_ClosemyModal" data-bs-dismiss="modal" Text="Close" class="btn btn-default btn-sm" OnClientClick="ClosePopupmyModal();return false;"></asp:Button>

                        </div>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <script type="text/javascript">

        function pageLoad() {
            $(".btn_AddItem").click(function () {
                //$('#myModal').zIndex(1050);
            });
            $(".btn_AddItem1").click(function () {
                //$('#creategroup').zIndex(1050);
                $('.modal-backdrop').remove();
            });
            isActive = false;
            mkadmin = false;
        }
        function ClosePopupcreategroup() {
            $('#creategroup').modal('hide');
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
            $('.Userlist').prop('checked', false);
            $("#txtsearchuser").val('');
            $("#txtgroupname").val('');
            chkarray = [];
            isActive = false;
            mkadmin = false;
        }
        function ClosePopupmyModal() {
            $('#myModal').modal('hide');
            $('#tbl_grpmemberlist').empty();
            $('#tbl_addgrpmemberlist').empty();
            chkarray = [];
            $('.RemoveMember').prop('checked', false);
            $('.makeMemberadmin').prop('checked', false);
            $('.AddMember').prop('checked', false);
            isActive = false;
            mkadmin = false;
        }

        function OpenPopup() {
            $('.btn_AddItem').click();
            //$('#myModal').zIndex(1050);

            $('.btn_AddItem1').click();
            //$('#creategroup').zIndex(1050);
        }

        function AlertBox(title, Message, type) {
            swal(title, Message, type);
        }

    </script>
</asp:Content>
