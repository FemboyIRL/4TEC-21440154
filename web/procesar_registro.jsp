<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>

<%
    String Remitente = request.getHeader("referer");

    if ((Remitente == null) || (Remitente.contains("http:localhost:8080/Practica2/"))) {
        response.sendRedirect("./index.jsp?error3=1");
        return;
    }
    String usuario = (String) session.getAttribute("usuario");
    String cursoSeleccionado = request.getParameter("cursoSeleccionado");
    String[] materiasSeleccionadas = request.getParameterValues("materiasSeleccionadas");

    if (usuario != null && cursoSeleccionado != null && materiasSeleccionadas != null) {
%>

<%
// Establecer la conexión con la base de datos
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rsMaterias = null;
    ResultSet rsProfesores = null;

    try {
        Class.forName("org.sqlite.JDBC");
        String url = "jdbc:sqlite:/C:/Users/luisr/OneDrive/Escritorio/Escuela del mal/Desarrollo web/Paginas/4TEC 21440154/web/assets/bd/usuarios.db";
        conn = DriverManager.getConnection(url);

        // Consulta SQL para obtener la lista de profesores
        String sqlProfesores = "SELECT * FROM profesores";
        stmt = conn.prepareStatement(sqlProfesores);
        rsProfesores = stmt.executeQuery();

        // Crear una lista para almacenar los profesores
        List<String> profesores = new ArrayList<String>();
        while (rsProfesores.next()) {
            profesores.add(rsProfesores.getString("nombre"));
        }

        request.setAttribute("profesores", profesores);

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rsMaterias != null) {
                rsMaterias.close();
            }
            if (rsProfesores != null) {
                rsProfesores.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seleccionar Profesores</title>
    </head>
    <body>
        <h2>Seleccionar Profesores</h2>
        <form action="registrarTodo.jsp" method="post">
            <input type="hidden" name="usuario" value="<%= usuario%>">
            <input type="hidden" name="cursoSeleccionado" value="<%= cursoSeleccionado%>">
            <% if (materiasSeleccionadas != null && materiasSeleccionadas.length > 0) {
                    for (String materia : materiasSeleccionadas) {

            %>
            <p><%= materia%></p>
            <% if(materia.equals("Lagrimas orientadas a objetos")){  %>
               <label><input type="radio" name="profeSeleccionado1" value="Faustinho" checked="checked">Faustinho</label>    
               <label><input type="radio" name="profeSeleccionado1" value="MedelAMLO" >MedelAMLO</label>    
                <%} else if(materia.equals("Drama distribuido")){ %>
               <label><input type="radio" name="profeSeleccionado2" value="Faustinho" checked="checked">Faustinho</label>    
               <label><input type="radio" name="profeSeleccionado2" value="MedelAMLO" >MedelAMLO</label> 
               <label><input type="radio" name="profeSeleccionado2" value="Ileanovska" >Ileanosvka</label>        
                   <% } else if(materia.equals("Redes artificiales")){ %>
               <label><input type="radio" name="profeSeleccionado3" value="Faustinho" checked="checked">Faustinho</label>    
               <label><input type="radio" name="profeSeleccionado3" value="MedelAMLO" >MedelAMLO</label>                  
               <label><input type="radio" name="profeSeleccionado3" value="Ileanovska" >Ileanovska</label>             
 <%}%>     

            <%
                }
            } else {
            %>
            <p>No se han seleccionado materias.</p>
            <% } %>
            

            <br>
            <input type="submit" value="Guardar Inscripción">
        </form>
            <button><a href="logout.jsp">Cerrar sesion</a></button>

    </body>
</html>

<%
    } else {
        response.sendRedirect("bienvenido.jsp?error=1");
    }
%>
