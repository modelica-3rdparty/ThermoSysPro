within ThermoSysPro.NuclearCore.Modules;
model BU_Linear
  extends ThermoSysPro.NuclearCore.Interfaces.BUinterface;
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[0,-30,-3,0,2e-05,
        0.0124,0.0305,0.111,0.301,1.14,3.01,0.00021,0.00142,0.00128,0.00257,
        0.00075,0.00027,-10,0,0; 1,-30,-3,0,2e-05,0.0124,0.0305,0.111,0.301,
        1.14,3.01,0.00021,0.00142,0.00128,0.00257,0.00075,0.00027,-10,0,0])
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(BUinput.Burnup, combiTable1Ds.u) annotation (Line(points={{-100,0},{
          -12,0}}, color={0,140,72}), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(combiTable1Ds.y, adaptorModelicaTSP.u)
    annotation (Line(points={{11,0},{44,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                                    Diagram(coordinateSystem(
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
end BU_Linear;
