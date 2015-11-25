<div class="header navbar navbar-inverse navbar-fixed-top">
    <!-- BEGIN TOP NAVIGATION BAR -->
    <div class="header-inner">

        <!-- BEGIN LOGO -->
        <a class="navbar-brand" href="home.jsp">
            <img src="images/logo.png" alt="logo" class="img-responsive">
        </a>
        <!-- END LOGO -->

        <!-- BEGIN SEARCH FIELD -->
        <div class="top-search-field">
            <form action="#" method="post">
                <div class="input-icon right">
                    <i class="fa fa-search"></i>
                <input type="text" class="form-control input-circle" placeholder="search...">
                </div>
            </form>
        </div>
        <!-- END SEARCH FIELD  -->


        <!-- BEGIN TOP NAVIGATION MENU -->
        <ul class="nav navbar-nav pull-right">
            <!-- BEGIN NOTIFICATION DROPDOWN -->
            <li class="dropdown" id="header_notification_bar">
                <jsp:include page="../shared/dropDown/notifications.jsp" flush="true"/>
            </li>
        <!-- END NOTIFICATION DROPDOWN -->

        <!-- BEGIN INBOX DROPDOWN -->
            <li class="dropdown" id="header_inbox_bar">
                <jsp:include page="../shared/dropDown/directMessages.jsp" flush="true"/>
            </li>
        <!-- END INBOX DROPDOWN -->


        <!-- BEGIN USER DROPDOWN -->
            <li class="dropdown user">
                <jsp:include page="../shared/dropDown/profile.jsp" flush="true"/>
            </li>
        <!-- END USER DROPDOWN -->

        </ul>
        <!-- END TOP NAVIGATION MENU -->
    </div>
    <!-- END TOP NAVIGATION BAR -->
</div>