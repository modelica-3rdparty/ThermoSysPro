within ThermoSysPro.FlueGases;
package Connectors "Connectors"
  extends ThermoSysPro.Properties.Common.ThermoSysProIcon;

  connector FlueGasesOutlet "Flue gases outlet fluid connector"
    Units.SI.AbsolutePressure P(start=1.e5)
      "Fluid pressure in the control volume";
    Units.SI.Temperature T(start=300) "Fluid temperature in the control volume";
    Units.SI.MassFlowRate Q(start=100)
      "Mass flow of the fluid crossing the boundary of the control volume";
    Real Xco2(start=0.01)
      "CO2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xh2o(start=0.05)
      "H2O mass fraction of the fluid crossing the boundary of the control volume";
    Real Xo2(start=0.2)
      "O2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xso2(start=0)
      "SO2 mass fraction of the fluid crossing the boundary of the control volume";

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
            lineThickness=1,
            fillPattern=FillPattern.Sphere,
            fillColor={191,0,0})}),
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
<p><u><b>Author</b></u> </p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
  end FlueGasesOutlet;

  connector FlueGasesInlet "Flue gases inlet fluid connector"
    Units.SI.AbsolutePressure P(start=1.e5)
      "Fluid pressure in the control volume";
    Units.SI.Temperature T(start=300) "Fluid temperature in the control volume";
    Units.SI.MassFlowRate Q(start=100)
      "Mass flow of the fluid crossing the boundary of the control volume";
    Real Xco2(start=0.01)
      "CO2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xh2o(start=0.05)
      "H2O mass fraction of the fluid crossing the boundary of the control volume";
    Real Xo2(start=0.2)
      "O2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xso2(start=0)
      "SO2 mass fraction of the fluid crossing the boundary of the control volume";

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
            lineThickness=1,
            fillPattern=FillPattern.Sphere,
            fillColor={127,127,255})}),
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
<li>Baligh El Hefni </li>
</ul>
</html>"));
  end FlueGasesInlet;

  connector FlueGasesInletI "Internal flue gases inlet fluid connector"
    Units.SI.AbsolutePressure P(start=1.e5)
      "Fluid pressure in the control volume";
    Units.SI.Temperature T(start=300) "Fluid temperature in the control volume";
    Units.SI.MassFlowRate Q(start=100)
      "Mass flow of the fluid crossing the boundary of the control volume";
    Real Xco2(start=0.01)
      "CO2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xh2o(start=0.05)
      "H2O mass fraction of the fluid crossing the boundary of the control volume";
    Real Xo2(start=0.2)
      "O2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xso2(start=0)
      "SO2 mass fraction of the fluid crossing the boundary of the control volume";

    input Boolean a
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
            lineThickness=1,
            fillColor={127,127,255},
            fillPattern=FillPattern.Forward)}),
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
<li>Baligh El Hefni </li>
</ul>
</html>"));
  end FlueGasesInletI;

  connector FlueGasesOutletI "Internal flue gases outlet fluid connector"
    Units.SI.AbsolutePressure P(start=1.e5)
      "Fluid pressure in the control volume";
    Units.SI.Temperature T(start=300) "Fluid temperature in the control volume";
    Units.SI.MassFlowRate Q(start=100)
      "Mass flow of the fluid crossing the boundary of the control volume";
    Real Xco2(start=0.01)
      "CO2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xh2o(start=0.05)
      "H2O mass fraction of the fluid crossing the boundary of the control volume";
    Real Xo2(start=0.2)
      "O2 mass fraction of the fluid crossing the boundary of the control volume";
    Real Xso2(start=0)
      "SO2 mass fraction of the fluid crossing the boundary of the control volume";

    output Boolean a
      "Pseudo-variable for the verification of the connection orientation";
    input Boolean b
      "Pseudo-variable for the verification of the connection orientation";

      annotation (
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,0,0},
            fillPattern=FillPattern.Forward)}),
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
<li>Baligh El Hefni </li>
</ul>
</html>"));
  end FlueGasesOutletI;
  annotation (Icon(graphics={Text(textString="")}));

end Connectors;
