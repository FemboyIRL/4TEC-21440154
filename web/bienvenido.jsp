<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%
    
    String Remitente = request.getHeader("referer");

    if ((Remitente == null) || (Remitente.contains("http:localhost:8080/Practica2/"))) {
        response.sendRedirect("./index.jsp?error3=1");
        return;
    }
String id = (String)session.getAttribute("id");
String usuario = (String)session.getAttribute("usuario");
String nombre = (String)session.getAttribute("nombre");
String ap_pat = (String)session.getAttribute("paterno");
String ap_mat = (String)session.getAttribute("materno");
String gen = (String)session.getAttribute("gen");
if(usuario != null) {
%>
<%
// Establecer la conexión con la base de datos
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rsMaterias = null;
ResultSet rsProfesores = null;
ResultSet rsCursos = null;

try {
    Class.forName("org.sqlite.JDBC"); 
    String url = "jdbc:sqlite:/C:/Users/luisr/OneDrive/Escritorio/Escuela del mal/Desarrollo web/Paginas/4TEC 21440154/web/assets/bd/usuarios.db";
    conn = DriverManager.getConnection(url);
    PreparedStatement psConsulta = conn.prepareStatement("SELECT COUNT(*) AS cantidad FROM inscripciones WHERE usuario_id = ?");
    psConsulta.setString(1, id);
    ResultSet rsConsulta = psConsulta.executeQuery();
    
    if (rsConsulta.next()) {
        int cantidadRegistros = rsConsulta.getInt("cantidad");
        if (cantidadRegistros > 0) {
            // Ya existe al menos un registro para este usuario, redirigir a confirmacion.jsp
            response.sendRedirect("confirmacion.jsp");
        }
    }else{}
    //Consulta SQL para obtener la lista de cursos   
    String sqlCursos = "";
       if (gen == null) {
    response.sendRedirect("index.jsp");
} else if (gen.equals("Masculino")) {
    sqlCursos = "SELECT * FROM cursos WHERE genero = 'Masculino'";
} else if (gen.equals("Femenino")) {
    sqlCursos = "SELECT * FROM cursos WHERE genero = 'Femenino'";
} else {
    sqlCursos = "SELECT * FROM cursos";
}
        stmt = conn.prepareStatement(sqlCursos);
        rsCursos = stmt.executeQuery();
    // Consulta SQL para obtener la lista de materias
    String sqlMaterias = "SELECT * FROM materias";
    stmt = conn.prepareStatement(sqlMaterias);
    rsMaterias = stmt.executeQuery();
    
    // Crear una lista para almacenar las materias
    List<String> materias = new ArrayList<String>();
    while (rsMaterias.next()) {
        materias.add(rsMaterias.getString("nombre"));
    }
    
    // Crear una lista para almacenar los cursos
    List<String> cursos = new ArrayList<String>();
    while (rsCursos.next()) {
    cursos.add(rsCursos.getString("nombre"));
    }

    
    

    // Guardar las listas de materias y cursos en el alcance de solicitud para que estén disponibles en la página JSP
    request.setAttribute("materias", materias);
    request.setAttribute("cursos", cursos);


} catch (ClassNotFoundException e) {
    e.printStackTrace();
} catch (SQLException e){
    e.printStackTrace();
} finally {
    try {
        if (rsMaterias != null) rsMaterias.close();
        if (rsProfesores != null) rsProfesores.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Bienvenido <%= nombre %> <%= ap_pat %> <%= ap_mat %> <br>Sexo: <%=gen%> <br> Usuario: <%= usuario%></h2>
        
       
            
            <h2>Selecciona tu curso</h2>
            <form action="procesar_registro.jsp" method="post">
                <% for (String curso : (List<String>) request.getAttribute("cursos")) { %>
                    <label><input type="radio" name="cursoSeleccionado" value="<%= curso %>" checked="checked"> <%= curso %></label>
                <% } %>
               <h2>Selecciona tus materias</h2>
                <% for (String materia : (List<String>) request.getAttribute("materias")) { %>
                <label><input type="checkbox" name="materiasSeleccionadas" value="<%= materia %>"> <%= materia %><Br></label>
                <% } %>
                <br><input type="submit" value="Inscribirse">
            </form>
                <button><a href="logout.jsp">Cerrar Sesion</a></button><br>    
                 <%
            String error=request.getParameter("error");
            if(error!=null){
            out.println("Llena todos los campos por favor");
            }%>
    </body>
</html>
<%
} else {
    response.sendRedirect("index.jsp");
}
%>
