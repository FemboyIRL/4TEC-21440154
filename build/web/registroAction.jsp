<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>
<meta charset="UTF-8">

<%
    String Remitente = request.getHeader("referer");

    if ((Remitente == null) || (Remitente.contains("http:localhost:8080/Practica2/"))) {
        response.sendRedirect("./index.jsp?error3=1");
        return;
    }
    String usuario = request.getParameter("usuario").trim();
    String contrasena = request.getParameter("contrasena").trim();
    String nombre = request.getParameter("nombre").trim();
    String ap_pat = request.getParameter("ap_pat").trim();
    String ap_mat = request.getParameter("ap_mat").trim();
    String genero = request.getParameter("genero").trim();
    String otroGenero = request.getParameter("otro").trim();
    boolean otro = false;
    
    if(usuario.equals("") || contrasena.equals("") || nombre.equals("") || ap_pat.equals("") || ap_mat.equals("") || genero.equals("")){
        response.sendRedirect("registro.jsp?error2=1");
        return; // Detener la ejecución si algún campo está vacío
    }
     if (genero.equals("Otro")) {
        genero = otroGenero;
        otro = true;
    }
     
    if (!usuario.matches("^[a-zA-Z0-9]+$")) {
    response.sendRedirect("registro.jsp?error5=1");
    return; // Detener la ejecución del script después de la redirección
}else if (!nombre.matches("^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\\s\\-.]+$")){
    response.sendRedirect("registro.jsp?error4=1");
    return;   
}else if(!ap_pat.matches("^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\\s\\-.]+$")){
    response.sendRedirect("registro.jsp?error4=1");
    return;
}else if(!ap_mat.matches("^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\\s\\-.]+$")){
    response.sendRedirect("registro.jsp?error4=1");
   return;
}else if(otro == true){
    if(!genero.matches("^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\\s\\-.]+$")){
            response.sendRedirect("registro.jsp?error4=1");

    }
}
  
   

    try {
        Class.forName("org.sqlite.JDBC");
        String url = "jdbc:sqlite:/C:/Users/luisr/OneDrive/Escritorio/Escuela del mal/Desarrollo web/Paginas/4TEC 21440154/web/assets/bd/usuarios.db";
        Connection conn = DriverManager.getConnection(url);
        PreparedStatement ps = conn.prepareStatement("INSERT INTO usuarios (nombre, usuario, contrasena, apellido_paterno, apellido_materno, genero) VALUES (?, ?, ?, ?, ?, ?)");
        ps.setString(1, nombre);
        ps.setString(2, usuario);
        ps.setString(3, contrasena);
        ps.setString(4, ap_pat);
        ps.setString(5, ap_mat);
        ps.setString(6, genero);

        int result = ps.executeUpdate();
        if (result > 0) {
            response.sendRedirect("index.jsp?registro=1");
        } else {
            out.println("Error al registrar usuario");
        }

        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("Error al registrar usuario: " + e.getMessage());      
        e.printStackTrace();
        
    }
%>
<br><button><a href="index.jsp" style="text-decoration: none; color: black">Volver al index</a></button>