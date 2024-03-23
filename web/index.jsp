<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>  
    <h2>Login</h2>
    <form action="loginAction.jsp" method="post">
        Usuario:  <input type="text" name="usuario"><br>
        Contraseña: <input type="password" name="contrasena"><br>
        <input type="submit" value="Iniciar sesión">
    </form>
    <button><a href="registro.jsp">Registrarse</a></button>
     <% 
        String error = request.getParameter("error");
        String error2 = request.getParameter("error2");
        String errordelmal = request.getParameter("errordelmal");

        if (error != null) {
            out.print("</br>Error: Usuario o contraseña incorrecta");
        }else if(error2 != null){
      out.print("</br>Error: Por favor llena todos los campos");
     }else if (errordelmal != null){
         out.print("Sesion cerrada exitosamente");
     }
                
       String registro = request.getParameter("registro");
       if (registro !=null) {
         out.print("</br> Registro exitoso");   
       }       
     %>
</body>
</html>
