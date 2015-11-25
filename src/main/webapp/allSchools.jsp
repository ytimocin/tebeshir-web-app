<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.School"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    School newSchool = new School();
    ArrayList<School> allSchools = newSchool.getAllActiveSchools();

    String schoolQuery = request.getParameter("q");
    
    String schoolName = null;
    for (int i = 0; i < allSchools.size(); i++) {
        schoolName = allSchools.get(i).getSchoolName();
        if (schoolName.toLowerCase().contains(schoolQuery.toLowerCase())) {
            out.println(schoolName);
        }
    }
%>
