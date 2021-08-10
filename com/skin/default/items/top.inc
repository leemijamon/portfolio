    <div class="header">
        <!-- Topbar -->
        <div class="topbar">
            <div class="container">
                <!-- Topbar Navigation -->
                <ul class="loginbar pull-right">
                    <li><a href="/">Home</a></li>
                    <li class="topbar-devider"></li>
<% If Login_check <> "Y" Then %>
                    <li><a href="<%=LINK_MEMBER_LOGIN%>">로그인</a></li>
                    <li class="topbar-devider"></li>
                    <li><a href="<%=LINK_MEMBER_JOIN%>">회원가입</a></li>
                    <li class="topbar-devider"></li>
<% Else %>
                    <li><a href="/exec/action/member.logout.asp">로그아웃</a></li>
                    <li class="topbar-devider"></li>
                    <li><a href="<%=LINK_MEMBER_MODIFY%>">회원정보수정</a></li>
                    <li class="topbar-devider"></li>
<% End If %>
                    <li><a href="<%=LINK_CUSTOMER%>">고객센터</a></li>
                </ul>
                <!-- End Topbar Navigation -->
            </div>
        </div>
        <!-- End Topbar -->

        <!-- Navbar -->
        <div class="navbar navbar-default" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="fa fa-bars"></span>
                    </button>
                    <a class="navbar-brand" href="/">
<%=TOPLOGO%>
                    </a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-responsive-collapse">
                    <ul class="nav navbar-nav">

<!-- #include virtual = "/skin/default/userskin/topmenu.inc" -->

                    </ul>
                </div><!--/navbar-collapse-->
            </div>
        </div>
        <!-- End Navbar -->
    </div>
