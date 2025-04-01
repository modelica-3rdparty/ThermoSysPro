within ThermoSysPro.Fluid.Examples.Book.PowerPlants;
package CombinedCyclePowerPlant "Models of a combined cycle power plant"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;

annotation (Icon(graphics={Text(textString="")}), Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024 </p>
<p><b>ThermoSysPro Version 4.1 </p>
<p>This package contains two models for a real combined cycle power plant:</p>
<ul>
<li>LoadVariation to simulate a load variation from 100&percnt; to 50&percnt;</li>
<li>GasTurbineTrip to simulate a full gas turbine trip</li>
</ul>
<p><br>The two models are documented in Sect. 6.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end CombinedCyclePowerPlant;
