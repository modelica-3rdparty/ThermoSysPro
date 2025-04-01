within ThermoSysPro.Fluid.Examples;
package CombinedCyclePowerPlant "Models of a combined cycle power plant"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;




annotation (
  Window(
    x=0.05,
    y=0.01,
    width=0.25,
    height=0.25,
    library=1,
    autolayout=1),
  Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}},
      grid={2,2},
      initialScale=0.1), graphics={Text(textString="")}),
  Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024 </p>
<p><b>ThermoSysPro Version 4.1 </p>
<p>This package contains two models of the same combined cycle power plant are provided to simulate two different transients:</p>
<ul>
<li>CombinedCycle_Load_100_50, to simulate a load decrease from 100&percnt; to 50&percnt;</li>
<li>CombinedCycle_TripTAC, to simulate a full combustion turbine trip</li></p>
</ul>
<p>The two models are documented in two conference papers, <a href=\"http://www.ep.liu.se/ecp/063/040/ecp11063040.pdf\">1</a> and <a href=\"http://www.ep.liu.se/ecp/132/046/ecp17132407.pdf\">2</a>. </h4>
</html>"));
end CombinedCyclePowerPlant;
