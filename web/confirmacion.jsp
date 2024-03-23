<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmación</title>
</head>
<body>
    <h1>Felicidades</h1>
    
    <% 
        String usuario = (String) session.getAttribute("usuario");
        Connection conn = null;
        PreparedStatement stmtUsuario = null;
        PreparedStatement stmtInscripciones = null;
        PreparedStatement stmtMateria = null;
        PreparedStatement stmtCurso = null;
        PreparedStatement stmtProfesor = null;
        ResultSet rsUsuario = null;
        ResultSet rsInscripciones = null;
        ResultSet rsMateria = null;
        ResultSet rsCurso = null;
        ResultSet rsProfesor = null;
        
        try {
            Class.forName("org.sqlite.JDBC");
            String url = "jdbc:sqlite:/C:/Users/luisr/OneDrive/Escritorio/Escuela del mal/Desarrollo web/Paginas/4TEC 21440154/web/assets/bd/usuarios.db";
            conn = DriverManager.getConnection(url);
            
            // Consulta SQL para obtener todos los datos del usuario excepto los campos que deseas excluir
            String sqlConsultaUsuario = "SELECT id, nombre, apellido_paterno, apellido_materno, genero FROM usuarios WHERE usuario = ?";
            stmtUsuario = conn.prepareStatement(sqlConsultaUsuario);
            stmtUsuario.setString(1, usuario); // Usuario obtenido del request
            
            rsUsuario = stmtUsuario.executeQuery();
            
            // Mostrar los datos del usuario en la página de confirmación
            if (rsUsuario.next()) {
                out.println("<h2>Datos del Usuario</h2>");
                out.println("ID: " + rsUsuario.getInt("id") + "<br>");
                out.println("Nombre: " + rsUsuario.getString("nombre") + "<br>");
                out.println("Apellido Paterno: " + rsUsuario.getString("apellido_paterno") + "<br>");
                out.println("Apellido Materno: " + rsUsuario.getString("apellido_materno") + "<br>");
                out.println("Género: " + rsUsuario.getString("genero") + "<br>");
                
                // Consulta SQL para obtener las inscripciones del usuario
                String sqlConsultaInscripciones = "SELECT * FROM inscripciones WHERE usuario_id = ?";
                stmtInscripciones = conn.prepareStatement(sqlConsultaInscripciones);
                stmtInscripciones.setInt(1, rsUsuario.getInt("id"));
                
                rsInscripciones = stmtInscripciones.executeQuery();
                
                // Mostrar las inscripciones del usuario
                out.println("<h2>Inscripciones</h2>");
                out.println("<table border='1'>");
                out.println("<tr><th>Materia</th><th>Curso</th><th>Profesor</th></tr>");
                while (rsInscripciones.next()) {
                    // Obtener los detalles de la inscripción (nombre de la materia, curso y profesor)
                    int materiaId = rsInscripciones.getInt("materia_id");
                    int cursoId = rsInscripciones.getInt("curso_id");
                    int profesorId = rsInscripciones.getInt("profesor_id");
                    
                    // Consulta SQL para obtener el nombre de la materia
                    String sqlConsultaMateria = "SELECT nombre FROM materias WHERE id = ?";
                    stmtMateria = conn.prepareStatement(sqlConsultaMateria);
                    stmtMateria.setInt(1, materiaId);
                    rsMateria = stmtMateria.executeQuery();
                    String nombreMateria = rsMateria.next() ? rsMateria.getString("nombre") : "No encontrado";
                    
                    // Consulta SQL para obtener el nombre del curso
                    String sqlConsultaCurso = "SELECT nombre FROM cursos WHERE id = ?";
                    stmtCurso = conn.prepareStatement(sqlConsultaCurso);
                    stmtCurso.setInt(1, cursoId);
                    rsCurso = stmtCurso.executeQuery();
                    String nombreCurso = rsCurso.next() ? rsCurso.getString("nombre") : "No encontrado";
                    
                    // Consulta SQL para obtener el nombre del profesor
                    String sqlConsultaProfesor = "SELECT nombre FROM profesores WHERE id = ?";
                    stmtProfesor = conn.prepareStatement(sqlConsultaProfesor);
                    stmtProfesor.setInt(1, profesorId);
                    rsProfesor = stmtProfesor.executeQuery();
                    String nombreProfesor = rsProfesor.next() ? rsProfesor.getString("nombre") : "No encontrado";
                    
                    // Mostrar los detalles de la inscripción
                    out.println("<tr>");
                    out.println("<td>" + nombreMateria + "</td>");
                    out.println("<td>" + nombreCurso + "</td>");
                    out.println("<td>" + nombreProfesor + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } else {
                out.println("Usuario no encontrado");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rsUsuario != null) {
                    rsUsuario.close();
                }
                if (stmtUsuario != null) {
                    stmtUsuario.close();
                }
                if (rsInscripciones != null) {
                    rsInscripciones.close();
                }
                if (stmtInscripciones != null) {
                    stmtInscripciones.close();
                }
                if (rsMateria != null) {
                    rsMateria.close();
                }
                if (stmtMateria != null) {
                    stmtMateria.close();
                }
                if (rsCurso != null) {
                    rsCurso.close();
                }
                if (stmtCurso != null) {
                    stmtCurso.close();
                }
                if (rsProfesor != null) {
                    rsProfesor.close();
                }
                if (stmtProfesor != null) {
                    stmtProfesor.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    <br>
    <button><a href="logout.jsp">Cerrar sesion</a></button>
</body>
</html>
