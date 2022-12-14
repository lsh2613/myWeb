<%@ page import="com.example.dto.Post" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.example.sql.Insert" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("utf-8");

    MultipartRequest multi = new MultipartRequest(request, "C:\\Users\\Lee Seung Heon\\Desktop\\Projects\\IntelliJProject\\KillTheBug\\src\\main\\webapp\\img\\post",
            5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
    request.setCharacterEncoding("utf-8");

    String title = multi.getParameter("title");
    String content = multi.getParameter("content");

    Enumeration files = multi.getFileNames();

    String imgName=null;
    while (files.hasMoreElements()) {
        String element = (String) files.nextElement();
        imgName = multi.getOriginalFileName(element);
    }

    String loginId = (String)session.getAttribute("loginId");

    Post post = new Post(loginId, title, content);
    post.setImgName(imgName);


    // sql insert

    Insert insert = Insert.getInsert();

    insert.insertPost(post);


    response.sendRedirect("index.jsp");

%>