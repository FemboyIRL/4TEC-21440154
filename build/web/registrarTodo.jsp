<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>


<%
    String Remitente = request.getHeader("referer");

    if ((Remitente == null) || (Remitente.contains("http:localhost:8080/Practica2/"))) {
        response.sendRedirect("./index.jsp?error3=1");
        return;
    }
    String usuario = request.getParameter("usuario");
    String cursoSeleccionado = request.getParameter("cursoSeleccionado");
    String profeSeleccionado1 = request.getParameter("profeSeleccionado1");
    String profeSeleccionado2 = request.getParameter("profeSeleccionado2");
    String profeSeleccionado3 = request.getParameter("profeSeleccionado3");

    out.println("Usuario: " + usuario);
    out.println("Curso seleccionado: " + cursoSeleccionado);
    out.println("Profesor seleccionado 1: " + profeSeleccionado1);
    out.println("Profesor seleccionado 2: " + profeSeleccionado2);
    out.println("Profesor seleccionado 3: " + profeSeleccionado3);

    Connection conn = null;
    PreparedStatement stmt = null;
    PreparedStatement stmt1 = null;
    PreparedStatement stmt2 = null;
    PreparedStatement stmt3 = null;
    ResultSet rs = null;

    try {
        Class.forName("org.sqlite.JDBC");
        String url = "jdbc:sqlite:/C:/Users/luisr/OneDrive/Escritorio/Escuela del mal/Desarrollo web/Paginas/4TEC 21440154/web/assets/bd/usuarios.db";
        conn = DriverManager.getConnection(url);

        // Obtener el ID del usuario
        String sqlUsuario = "SELECT id FROM usuarios WHERE usuario = ?";
        stmt = conn.prepareStatement(sqlUsuario);
        stmt.setString(1, usuario);
        rs = stmt.executeQuery();
        int usuarioId = -1; // Valor por defecto si no se encuentra el usuario
        if (rs.next()) {
            usuarioId = rs.getInt("id");
            out.print("Usuario ID: " + usuarioId); // Imprimir el usuarioId
        } else {
            response.sendRedirect("index.jsp");
        }
        rs.close();
        stmt.close();
        
        // Obtener el ID del curso
        String sqlCurso = "SELECT id FROM cursos WHERE nombre = ?";
        stmt = conn.prepareStatement(sqlCurso);
        stmt.setString(1, cursoSeleccionado);
        rs = stmt.executeQuery();
        int cursoId = -1; // Valor por defecto si no se encuentra el curso
        if (rs.next()) {
            cursoId = rs.getInt("id");
            out.print("Curso ID: " + cursoId); // Imprimir el cursoId
        } else {
            response.sendRedirect("index.jsp");
        }
        rs.close();
        stmt.close();
        
        // Insertar los datos en la tabla de inscripciones
        String sqlInsert = "INSERT INTO inscripciones (usuario_id, materia_id, curso_id , profesor_id) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(sqlInsert);
        
        // Obtener los IDs de los profesores
        String sqlProfesor = "SELECT id FROM profesores WHERE nombre = ?";
        stmt1 = conn.prepareStatement(sqlProfesor);
        stmt2 = conn.prepareStatement(sqlProfesor);
        stmt3 = conn.prepareStatement(sqlProfesor);

        // Profesor 1
        if(profeSeleccionado1 != null){
        stmt1.setString(1, profeSeleccionado1);
        rs = stmt1.executeQuery();
        int profeId1 = -1; // Valor por defecto si no se encuentra el profesor
        if (rs.next()) {
            profeId1 = rs.getInt("id");
            // Insertar la primera materia y su profesor
            stmt.setInt(1, usuarioId);
            stmt.setInt(2, 1);
            stmt.setInt(3, cursoId);
            stmt.setInt(4, profeId1);
            stmt.executeUpdate();
            

        } else {
            response.sendRedirect("index.jsp");
        }
        rs.close();
        stmt1.close();
        }

        // Profesor 2
        if(profeSeleccionado2 != null){
        stmt2.setString(1, profeSeleccionado2);
        rs = stmt2.executeQuery();
        int profeId2 = -1; // Valor por defecto si no se encuentra el profesor
        if (rs.next()) {
            profeId2 = rs.getInt("id");
 // Insertar la segunda materia y su profesor
        stmt.setInt(1, usuarioId);
        stmt.setInt(2, 2);
        stmt.setInt(3, cursoId);
        stmt.setInt(4, profeId2);
        stmt.executeUpdate();
        } else {
            response.sendRedirect("index.jsp");
        }
        rs.close();
        stmt2.close();
}
        
// Profesor 3
        if(profeSeleccionado3 != null){ 
        stmt3.setString(1, profeSeleccionado3);
        rs = stmt3.executeQuery();
        int profeId3 = -1; // Valor por defecto si no se encuentra el profesor
        if (rs.next()) {
            profeId3 = rs.getInt("id");
        // Insertar la tercera materia y su profesor
        stmt.setInt(1, usuarioId);
        stmt.setInt(2, 3);
        stmt.setInt(3, cursoId);
        stmt.setInt(4, profeId3);
        stmt.executeUpdate();
                } else {
            response.sendRedirect("index.jsp");
        }
        rs.close();
        stmt3.close();
        }
       
          
       
        // Redirigir a una página de confirmación
        response.sendRedirect("confirmacion.jsp");


       
              
    } catch (SQLException e) {
        e.printStackTrace(); // Imprimir el error en la consola
    } finally {
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Imprimir el error de cierre de la conexión en la consola
        }
    }
%>
