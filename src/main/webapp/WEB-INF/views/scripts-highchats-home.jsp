<script type="text/javascript">

$(function() {

    // umidade
    var chart = new Highcharts.Chart(
            { chart : { renderTo : 'container-umidade', type : 'pie', margin : [ -85, 0, 0, 0 ], backgroundColor : 'transparent' },
                title : { text : false, }, credits : { enabled : false }, exporting : { enabled : false },
                plotOptions : { pie : { innerSize : '100%' } },
                tooltip : { formatter : function() { return false; } },
                series : [ { name : 'Browsers', data : [ { name : "Umidade", y : ${dados.umidade} }, { name : "Null", y : 100 - ${dados.umidade}, color : 'transparent' } ],
                    size : '80%', innerSize : '75%', showInLegend : false, dataLabels : { enabled : false }, borderColor : '#e8e8e8' } ]
            },

            function(chart) { // on complete
                var textX = chart.plotLeft + (chart.plotWidth * 0.5);
                var textY = chart.plotTop + (chart.plotHeight * 0.5);

                var span = '<span id="pieChartInfoText" style="position:absolute; text-align:center;">';
                span += '<span style="font-size: 44px; margin-top:-3px; position: absolute;margin-left: -48px; color: #888">${dados.umidade}%</span><br>';
                span += '</span>';

                $("#addText").append(span);
                span = $('#pieChartInfoText');
                span.css('left', textX + (span.width() * -0.5));
                span.css('top', textY + (span.height() * -0.5));
            });

    // rosa dos ventos
    $('#container-rose').highcharts({
        chart: { type : 'column', backgroundColor : 'transparent', polar: true },
        pane : { size : '88%' },
        title : { text : false, },
        credits : { enabled : false },
        exporting : { enabled : false },
        data : { startRow : 1, endRow : 10, endColumn : 7, },
        yAxis: { min: 0, endOnTick: false, showLastLabel: false, labels: { enabled :false } },
        xAxis: { tickmarkPlacement : 'on',
        categories: [${direcoes}], labels: { formatter: function () { return this.value + ''; } } }, legend : { enabled : false },
        tooltip : { formatter : function() { return 'Sentido ${dados.sentidoVento}'; } },
        plotOptions : { series : { stacking : 'normal', shadow : false, groupPadding : 0, pointPlacement : 'on' } },
        series: [ { data: [${dados.direcaoVento}] } ]
     });

    // velocidade e rota��o
    var gaugeOptions = {

        chart : { type : 'solidgauge', width : 235, margin : [ 10, 0, 10, 0 ], backgroundColor : 'transparent' },
        title : null, credits : { enabled : false }, exporting : { enabled : false },
        pane : { center : [ '50%', '85%' ], size : '140%', startAngle : -90, endAngle : 90,
            background : { backgroundColor : (Highcharts.theme && Highcharts.theme.background2) || '#EEE', innerRadius : '60%', outerRadius : '100%', shape : 'arc' }
        },
        tooltip : { enabled : false },
        yAxis : { stops : [ [ 0.1, '#55BF3B' ], [ 0.5, '#DDDF0D' ],  [ 0.9, '#DF5353' ]  ],
            lineWidth : 0, minorTickInterval : null, tickPixelInterval : 400, tickWidth : 0, title : { y : -70 },
            labels : { y : 16 }
        },
        plotOptions : { solidgauge : { dataLabels : { y : 5, borderWidth : 0, useHTML : true } } }
    };

    // The speed gauge
    $('#container-speed').highcharts( Highcharts.merge(
        gaugeOptions, { yAxis : { min : 0, max : 200 }, title : { text : false }, credits : { enabled : false },
            exporting : { enabled : false }, series : [ { name : 'Velocidade do Vento', data : [ ${dados.velocidade} ],
                                            dataLabels : { format : '<div style="text-align:center"><span style="font-size:25px;color:#888'
                                                + '">{y}</span><br/>'
                                                        + '<span style="font-size:12px;color:silver">km/h</span></div>'
                                            }, tooltip : { valueSuffix : ' km/h' } } ]  }));

    // The RPM gauge
    $('#container-rpm').highcharts( Highcharts.merge(
        gaugeOptions, { yAxis : { min : 0, max : 20 }, title : { text : false }, credits : { enabled : false },
            exporting : { enabled : false }, series : [ { name : 'Rota��es por Minutor', data : [ ${dados.rotacao} ],
                                            dataLabels : { format : '<div style="text-align:center"><span style="font-size:25px;color:#888'
                                                + '">{y:.1f}</span><br/>'
                                                        + '<span style="font-size:12px;color:silver">* 1000 r/min</span></div>'
                                            },
                                            tooltip : { valueSuffix : ' revolutions/min' } } ] }));

    // uv
    $('#container-uv').highcharts({

        chart : { type : 'gauge', backgroundColor : 'transparent', margin : [ -95, 0, 0, -15 ] },
        credits : { enabled : false }, exporting : { enabled : false },
        title : { text : false },
        pane : { startAngle : -90, endAngle : 90, background : null },
        plotOptions : {
            gauge : { dataLabels : { borderWidth : 0, useHTML : true },
                dial : { baseLength : '63%', baseWidth : 10, radius : '95%', rearLength : '-63%', topWidth : 1 }
            }
        },
        tooltip : { enabled : false },
        yAxis : { labels : { enabled : true, x : 30, y : -25, format: '{value:0.f}', },
            tickPositions : [ 90000, 100000 ],
            minorTickLength : 0,
            min : 0,
            max : 140000,
            plotBands : [ {
                from : 0,
                to : 101300,
                color : '#ff6347', // orange
                thickness : '40%'
            }, {
                from : 101300,
                to : 140000,
                color : '#F34E54', // red
                thickness : '40%'
            } ]
        },
        series : [ {
            name : 'Press�o Atmosf�rica',
            data : [ ${dados.pressao} ],
            dataLabels : {
                x: 0,
                y: -60,
                format : '<div style="text-align:center"><span style="font-size:25px;color:#888'
                    + '">{y:0.f}</span><br/>'
                    + '<span style="font-size:12px;color:silver">Pa</span>'
            }, tooltip : { pointFormat: "Press�o Atmosf�rica {point.y:.0f} Pa" } }] });
});

</script>