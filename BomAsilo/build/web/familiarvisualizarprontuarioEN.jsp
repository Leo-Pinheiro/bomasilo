<!-- 
***********************************************************************************************************
* ENTRA21 - JAVA WEB MATUTINO 2021                                                                        *
* PROJETO BOM ASILO                                                                                       *
* EQUIPE: EDUARDA STEFFEN, LUCAS RAFAEL BOOZ, TAINARA DA SILVA BORBA, LEONARDO LUIZ MOREIRA PINHEIRO      *
***********************************************************************************************************
-->
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="modelos.Prontuario"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Familiar"%>
<%@page import="modelos.Paciente"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/estilosconsulta.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>  
        <script src="scripts/formatacampos.js"></script>
    </head>
    <header>
        <script>
            function validaAcesso(p1) {
                if (p1 === "") {
                    alert("You need to login first!");
                    window.top.location.href = "indexEN.html";
                } else if (p1 !== "familiar") {
                    alert("You don't have the acess to this page!");
                    window.top.location.href = "menufamiliarEN.jsp";
                }
            }
        </script> 
    
    <body>
    <h1>Prontuary Info</h1>
    <hr />
   
    <%
        String usuarioLogado = "";

        if (session.getAttribute("usuarioLogado") != null) {
            usuarioLogado = session.getAttribute("usuarioLogado").toString();
        }
    %>
    <%
        Prontuario pro = new Prontuario();
        Familiar familiar = new Familiar();
        Paciente paciente = new Paciente();

        List<Prontuario> prontuario = pro.consultarProntuarioPaciente(paciente.consultarPaciente(familiar.consultarFamiliar(usuarioLogado).getCpfPaciente()));
    %>
    <table class="table table-striped">
        <thead>
        <th scope="col"> Appointment Date</th>
        <th scope="col"> Blood Type </th>
        <th scope="col"> Weight </th>
        <th scope="col"> Height </th>
        <th scope="col"> BMI </th>
        <th scope="col"> Cognitive Limitation </th>
        <th scope="col"> Locomotive Limitation </th>
        <th scope="col"> Visual Limitation </th>
        <th scope="col"> Auditory Limitation </th>
        <th scope="col"> Other Limitation </th>
        <th scope="col"> Allergy </th>
        <th scope="col"> Occupation </th>
        <th scope="col"> Patient </th>
    </thead>
    <tbody>
        <% for (Prontuario pr : prontuario) { %>
        <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                String dataConsulta = "";
                   if (pr.getDataConsulta() != null) {
                    dataConsulta = sdf.format(pr.getDataConsulta());
                }
            %>
        <tr>
            <td><% out.write(dataConsulta);  %></td>
            <td><% out.write(pr.getTipoSangue());  %></td>
            <td><% out.write("" + pr.getPeso()); %></td>
            <td><% out.write("" + pr.getAltura()); %></td>
            <td><% out.write("" + pr.getImc()); %></td>
            <td><% if (pr.isLimitCognitiva()) {
                        out.write("Yes");
                    } else {
                        out.write("No");
                    } %></td>
            <td><% if (pr.isLimitLocomocao()) {
                        out.write("Yes");
                    } else {
                        out.write("No");
                    } %></td>
            <td><% if (pr.isLimitVisao()) {
                        out.write("Yes");
                    } else {
                        out.write("No");
                    } %></td>
            <td><% if (pr.isLimitAudicao()) {
                        out.write("Yes");
                    } else {
                        out.write("No");
                    } %></td>
            <td><% out.write("" + pr.getLimitOutras()); %></td>
            <td><% out.write(pr.getDescAlergia()); %></td>
            <td><% out.write(pr.getDescOcupacao()); %></td>
            <td><% out.write("" + pr.getPacienteProntuario().getNome()); %></td>

        </tr> 
        <%}%>
    </tbody>
</table>
</form> 
</body>
</header>
</html>