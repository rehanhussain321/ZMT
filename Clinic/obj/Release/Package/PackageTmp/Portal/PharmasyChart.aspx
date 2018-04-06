<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PharmasyChart.aspx.cs" Inherits="Clinic.Portal.PharmasyChart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        
        <script src="../assets/jquery-1.4.1.min.js"></script>
        <script src="http://code.highcharts.com/highcharts.js"></script>
        <script src="http://code.highcharts.com/modules/exporting.js"></script>
    <script type="text/javascript">
    var data = [];
    var datasecond = [];
    var datathird = [];
    $(document).ready(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "MainPageChart.asmx/PharmasyCountAnalysis",
            data: "{}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;


                for (var i in Result) {
                    var serie = new Array(Result[i].Item_Name, Result[i].Pharmasy_User);
                    data.push(serie);
                }

                DreawChart(data);

            },
            error: function (Result) {
                alert("Error");
            }
        });
    });

    function DreawChart(series) {
        Highcharts.setOptions({                   //For Removing HIghcharts Export Option
            exporting: {                               //For Removing HIghcharts Export Option
                enabled: false                          //For Removing HIghcharts Export Option
            }                                           //For Removing HIghcharts Export Option
        })                                             //For Removing HIghcharts Export Option
        $('#graph').highcharts({

            chart: {

                spacingBottom: 15,
                spacingTop: 10,
                spacingLeft: 10,
                spacingRight: 10,
                /*  width:555,*/
               /* height: 520,*/
                plotBackgroundColor: null,
                plotBorderWidth: null, //null,
                plotShadow: false,
                //                backgroundColor: {
                //                    linearGradient: [8, 34, 53],  //Graph background color set here...
                //                    stops: [
                //                    [0, 'rgb( 8, 34, 53)'],
                //                    [1, 'rgb( 8, 34, 53)']

                //                ]
                //                }
                backgroundColor: 'white'
            },
            title: {
                text: ''
            },
            //                        tooltip: {
            //                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            //                        },
            xAxis: {
                //color: 'black',

                categories: seriesxAxis(series),
                labels: {
                    style: {
                        color: ''
                    }
                }


            },
            yAxis: {
                title: {
                    text: ''
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true,
                        color: 'black'
                    },
                    enableMouseTracking: false
                }
            },

            series: [{
                type: 'line',
                name: 'Pharmasy Use',
                color: 'Blue',
                data: series
            }]
            // }
        });


    }
    function seriesxAxis(series) {
        var serie = new Array(5);
        for (var i in series) {
            serie[i] = series[i][0];
        }
        return serie;
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
   <div class="card card-danger"  style="width:50%;">
       <div class="card-block">
             <h4></h4>
             <div class="card-img-top">
              <div id="graph" style="width:98%;height:95%;position:absolute">
         
             </div>
            </div>
       </div>
   </div>
    
    </form>
</body>
</html>
