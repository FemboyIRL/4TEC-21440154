<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>

<%
String usuario = request.getParameter("usuario");
String contrasena = request.getParameter("contrasena");

try {
    Class.forName("org.sqlite.JDBC");
    
    String url = "jdbc:sqlite:/C:/Users/luisr/OneDrive/Escritorio/Escuela del mal/Desarrollo web/Paginas/4TEC 21440154/web/assets/bd/usuarios.db";

    Connection conn = DriverManager.getConnection(url);


    PreparedStatement ps = conn.prepareStatement("SELECT * FROM usuarios WHERE usuario=? AND contrasena=?");
    ps.setString(1, usuario);
    ps.setString(2, contrasena);

    ResultSet rs = ps.executeQuery();
    if(rs.next()) {
        String nombre = rs.getString("nombre");
        String ap_pat = rs.getString("apellido_paterno");
        String ap_mat = rs.getString("apellido_materno");
        String genero = rs.getString("genero");
        String id = rs.getString("Id");
        session.setAttribute("usuario", usuario);
        session.setAttribute("contrasena", contrasena);
        session.setAttribute("nombre", nombre);
        session.setAttribute("paterno", ap_pat);
        session.setAttribute("materno", ap_mat);
        session.setAttribute("gen", genero);
        session.setAttribute("id", id);
        response.sendRedirect("bienvenido.jsp");
    } else {
    response.sendRedirect("index.jsp?error=1");
    }

    conn.close();
} catch (Exception e) {
    out.println(e);
}
%>