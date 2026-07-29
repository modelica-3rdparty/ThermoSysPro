within ThermoSysPro.NuclearCore.Interfaces;
partial model BUinterface
  parameter Integer Nrods = 3;
  ThermoSysPro.NuclearCore.Interfaces.BUinput BUinput
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  InstrumentationAndControl.AdaptorForFMU.AdaptorModelicaTSP adaptorModelicaTSP[16 +
    Nrods] annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  InstrumentationAndControl.Connectors.OutputReal outputReal[16 + Nrods]
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
equation
  connect(adaptorModelicaTSP.outputReal,outputReal)
    annotation (Line(points={{67,0},{104,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-68,98},{76,-102}},
          textColor={28,108,200},
          textString="BUmodel")}), Diagram(coordinateSystem(preserveAspectRatio
          =false)));
end BUinterface;
