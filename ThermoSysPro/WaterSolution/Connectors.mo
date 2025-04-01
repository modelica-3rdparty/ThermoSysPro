within ThermoSysPro.WaterSolution;
package Connectors "Connectors"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;

  connector WaterSolutionInlet "Water solution inlet"
    Units.SI.AbsolutePressure P "Fluid pressure in the control volume";
    Units.SI.Temperature T "Fluid temperature in the control volume";
    Units.SI.MassFlowRate Q
      "Mass flow of the fluid crossing the boundary of the control volume";
    Real Xh2o "H20 mass fraction of the solution in the control volume";

    input Boolean a=true
      "Pseudo-variable for the verification of the connection orientation";
    output Boolean b
      "Pseudo-variable for the verification of the connection orientation";

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,0},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid), Line(points={{-100,100},{100,-100}},
              color={255,255,255})}),
      Window(
        x=0.31,
        y=0.13,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Beno&icirc;t Bride </li>
</ul>
</html>"));
  end WaterSolutionInlet;

  connector WaterSolutionOutlet "Water solution outlet"
    Units.SI.AbsolutePressure P "Fluid pressure in the control volume";
    Units.SI.Temperature T "Fluid temperature in the control volume";
    Units.SI.MassFlowRate Q
      "Mass flow of the fluid crossing the boundary of the control volume";
    Real Xh2o "H20 mass fraction of the solution in the control volume";

    output Boolean a
      "Pseudo-variable for the verification of the connection orientation";
    input Boolean b=true
      "Pseudo-variable for the verification of the connection orientation";

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
            extent={{-100,-100},{102,100}},
            lineColor={0,0,0},
            fillColor={255,85,85},
            fillPattern=FillPattern.Solid), Line(points={{-100,100},{102,-100}},
              color={255,255,255})}),
      Window(
        x=0.31,
        y=0.13,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2024</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 4.1</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Beno&icirc;t Bride </li>
</ul>
</html>"));
  end WaterSolutionOutlet;
  annotation (Icon(graphics={Text(textString="")}));

end Connectors;
