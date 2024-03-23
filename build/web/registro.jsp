<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro</title>
    </head>
    <body>
        <h2>Registro de usuario</h2>
        <form accept-charset="UTF-8" action="registroAction.jsp" method="post">

            Usuario: <input type="text" name="usuario">
            <%
            String error5 = request.getParameter("error5");
            if(error5 != null){
                out.print("Solo puedes ingresar letras y numeros en este campo");
            }
            %><br> 
            Contraseña: <input type="password" name="contrasena"><br>
            Nombre: <input type="text" name="nombre"> <%
            String error4 = request.getParameter("error4"); %>
            <% if(error4 != null){
                out.print("Solo puedes ingresar letras y numeros en los campos nombre, apellido paterno, apellido materno y genero");
            }
            %><br> 
            Apellido Paterno: <input type="text" name="ap_pat"> 
           
            <br>
            Apellido Materno: <input type="text" name="ap_mat">
           
            <br>
            Género: <br>
            <input type="radio" name="genero" value="Masculino" checked="checked" /> Masculino <br> 
            <input type="radio" name="genero" value="Femenino" /> Femenino <br>
            <input type="radio" name="genero" value="Otro" /> Otro (Especifica): <input type="text" name="otro" />
            <input type="submit" value="Registrarse">
            <% String error2 = request.getParameter("error2");
               if (error2 != null){               
                out.print("</br>Error: Por favor llena todos los campos");
               }
            %>
        </form>


        </form>          
        <button><a href="index.jsp" style="text-decoration: none; color: black">Volver al index</a></button>
    </body>
</html>

