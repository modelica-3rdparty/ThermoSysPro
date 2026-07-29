within ThermoSysPro.NuclearCore.Modules;
model KinParam_BU_Linear
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal inputReal
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal outputReal[19]
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0,-30,-3,0,2e-05,
        0.0124,0.0305,0.111,0.301,1.14,3.01,0.00021,0.00142,0.00128,0.00257,
        0.00075,0.00027,-10,0,0; 1,-30,-3,0,2e-05,0.0124,0.0305,0.111,0.301,
        1.14,3.01,0.00021,0.00142,0.00128,0.00257,0.00075,0.00027,-10,0,0])
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  ThermoSysPro.InstrumentationAndControl.AdaptorForFMU.AdaptorTSPModelica
    adaptorTSPModelica
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  ThermoSysPro.InstrumentationAndControl.AdaptorForFMU.AdaptorModelicaTSP
    adaptorModelicaTSP[19]
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
equation
  connect(inputReal, adaptorTSPModelica.inputReal)
    annotation (Line(points={{-98,0},{-67,0}}, color={0,0,255}));
  connect(adaptorTSPModelica.y, combiTable1Ds.u)
    annotation (Line(points={{-44,0},{-12,0}}, color={0,0,127}));
  connect(combiTable1Ds.y, adaptorModelicaTSP.u)
    annotation (Line(points={{11,0},{44,0}}, color={0,0,127}));
  connect(adaptorModelicaTSP.outputReal, outputReal)
    annotation (Line(points={{67,0},{104,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-68,98},{76,-102}},
          textColor={28,108,200},
          textString="KinParam")}), Diagram(coordinateSystem(
          preserveAspectRatio=false), graphics={Text(
          extent={{30,-16},{96,-124}},
          textColor={28,108,200},
          textString="1. alfa_mod
2. alfa_dop
3. RhoGd
4. Tlife
5-10. Lambda
11-16. Beta
17-19. RodsWorth",
          horizontalAlignment=TextAlignment.Left)}));
end KinParam_BU_Linear;
