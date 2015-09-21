<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row">
    <div class="col-md-12">

        <c:choose>
            <c:when test="${empty temperaturas}">
                <div class="mensagem-dado-indisponivel">Ainda não temos informações disponíveis para este gráfico. </div>
            </c:when>
            <c:otherwise>
                <div id="container" style="height: 400px;" class="chart"></div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<c:if test="${not empty temperaturas}">

<script>

    $(function() {

        var ranges = [
                    <c:forEach var="temp" items="${temperaturas}" varStatus="it">
                        ['${temp.dataString}', ${temp.min}, ${temp.max}]${!it.last ? ',' : '' }
                    </c:forEach>
                  ],
         averages = [
                    <c:forEach var="temp" items="${temperaturas}" varStatus="it">
                        ['${temp.dataString}', ${temp.med}, ]${!it.last ? ',' : '' }
                    </c:forEach>
                  ];

        $('#container').highcharts(
                {

                    title: {
                        text: 'Últimas Variações de Temperatura'
                    },
                    subtitle: {
                        text: 'As últimas 30 horas captadas.'
                    },

                    xAxis: {
                        type: 'category',
                        tickInterval: 5,
                        tickWidth: 1
                    },

                    yAxis: {
                        title: {
                            text: ''
                        },
                        labels: {
                            format: '{value}°C'
                        },
                    },

                    tooltip: {
                        crosshairs: {
                            width: 1,
                            color: '#999'
                        },
                        shared: true,
                        valueSuffix: ' °C',
                        useHTML: true,
                        headerFormat: '<b><u><span font-size:15px">{point.key}</span></u></b><br>'
                    },

                    legend: {
                    },

                    series: [{
                        name: 'Temperatura',
                        data: averages,
                        zIndex: 1,
                        marker: {
                            fillColor: 'white',
                            lineWidth: 2,
                            lineColor: Highcharts.getOptions().colors[0]
                        }
                    }, {
                        name: 'Variação',
                        data: ranges,
                        type: 'arearange',
                        lineWidth: 0,
                        linkedTo: ':previous',
                        color: Highcharts.getOptions().colors[0],
                        fillOpacity: 0.3,
                        zIndex: 0
                    }]

                });

    });
</script>

</c:if>