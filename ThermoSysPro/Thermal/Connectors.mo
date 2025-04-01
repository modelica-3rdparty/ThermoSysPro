within ThermoSysPro.Thermal;
package Connectors "Connectors"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;

  connector ThermalPort "Thermal connector"
    Units.SI.Temperature T "Temperature";
    flow Units.SI.HeatFlowRate W
      "Thermal flow rate. Positive when going into the component";
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={255,127,0})}),
      Window(
        x=0.12,
        y=0.27,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
"));
  end ThermalPort;
  annotation (Icon(graphics={Text(textString="")}));

end Connectors;
