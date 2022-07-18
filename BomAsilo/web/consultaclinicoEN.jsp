<!-- 
***********************************************************************************************************
* ENTRA21 - JAVA WEB MATUTINO 2021                                                                        *
* PROJETO BOM ASILO                                                                                       *
* EQUIPE: EDUARDA STEFFEN, LUCAS RAFAEL BOOZ, TAINARA DA SILVA BORBA, LEONARDO LUIZ MOREIRA PINHEIRO      *
***********************************************************************************************************
-->
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Clinico"%>
<%@page import="modelos.Especialidade"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/estilosconsulta.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>  
        <script src="scripts/formatacampos.js"></script>
    <header>
        <script>
            function validaAcesso(p1) {
                if (p1 === "") {
                    alert("You need to login first!");
                    window.top.location.href = "indexEN.html";
                } else if ((p1 !== "adm") && (p1 !== "profsaude")) {
                    alert("You don't have the acess to this page!");
                    window.top.location.href = "menuEN.jsp";
                }
            }
        </script> 
        <body>
            <%
                String tipoAcesso = "";
                if (session.getAttribute("tipoAcesso") != null) {
                    tipoAcesso = session.getAttribute("tipoAcesso").toString();
                }
                System.out.println("Tipo:" + tipoAcesso);
                out.write("<script>validaAcesso(\"" + tipoAcesso + "\");</script>");
            %>

            <h1>Doctor List</h1>
            <hr />
            <label class="cabecalho" id="msg"> 
                <%
                    if (request.getParameter("pmensagem") != null)
                        out.write(request.getParameter("pmensagem"));
                %>
            </label>
            <%
                Clinico cli = new Clinico();
                List<Clinico> clinico = cli.consultarGeral();
                Especialidade esp = new Especialidade();
            %>
            <table class="table table-striped">
                <thead> 
                <th scope="col">Doctor's Name</th>
                <th scope="col">Registration Code</th>
                <th scope="col">Medical Speciality</th>
                <th scope="col"> Edit </th>
                <th scope="col"> Delete </th>
                </thead>
                <tbody>
                    <% for (Clinico c : clinico) { %>
                    <tr>
                        <td><% out.write("" + c.getNomeClinico());   %></td>
                        <td><% out.write("" + c.getCodRegistro());  %></td>
                        <td><% out.write("" + c.getEspecialidadeClinico().getDescEspecialidade());%></td>
                        <td><%out.write("<a href=editaclinicoEN.jsp?idClinico=" + c.getIdClinico() + ">" + "<i class='fas fa-edit' style='color=black'></i>" + "</a>");%></td> 
                        <td>
                            <a type="button" id="botaoexcluir"
                               onclick="mostrarExclusao(<%out.write("" + c.getIdClinico());%>)">
                                <i class="fas fa-trash-alt" style='color:red'></i> 
                            </a>
                        </td>                                               
                    </tr> 
                    <%}%>
                </tbody>
            </table>
            </form> 
            <!-- POPUP DE CONFIRMA��O DE EXCLUS�O -->                

            <div class="msg-popup2">
                <h5 class="text-center" style="color: #ffffff; font-family: arial-bold ">DELETE</h5>
                <h5 class="text-center" style="color: #ffffff;">Are you sure that you want to <b>delete</b> this register?</h5>
                <div class="text-center">                
                    <a href=""><button class="btn btn-dark" onclick="cancela()"> No </button></a>
                    <a id="exclui" href="#"><button class="btn btn-danger" id="excluir"> Yes </button></a>                    
                </div>
            </div>                

            <script>
                function cancela() {
                    document.getElementsByClassName("msg-popup2")[0].style.display = "none";
                }

                function mostrarExclusao(clinico) {
                    //debugger;
                    document.getElementsByClassName("msg-popup2")[0].style.display = "block";
                    var link = document.getElementById("exclui");
                    link.href = "excluiclinicoEN.jsp?idClinico=" + clinico;
                }
            </script>                  
        </body>
</html>