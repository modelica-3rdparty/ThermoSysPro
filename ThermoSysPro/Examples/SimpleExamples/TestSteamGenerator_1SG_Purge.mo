within ThermoSysPro.Examples.SimpleExamples;
model TestSteamGenerator_1SG_Purge
  extends TestSteamGenerator_1SG;

  parameter ThermoSysPro.Units.SI.MassFlowRate Q_Purges=5.55  "Purge massflowrate per SG" annotation (Dialog(group="Secondary"));

  WaterSteam.BoundaryConditions.SinkQ sinkQ1(Q0=Q_Purges, h0=1.278e6) annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  WaterSteam.Sensors.SensorT SensorT_Tpurge annotation (Placement(transformation(
        origin={58,8},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(SensorT_Tpurge.C2, sinkQ1.C) annotation (Line(points={{68.2,0},{80,0}}, color={0,0,255}));
  connect(steamGenerator.fluidOutletI_purge, SensorT_Tpurge.C1) annotation (Line(points={{7.8,-20.8},{7.8,-20},{26,-20},{26,0},{48,0}}, color={255,0,0}));
end TestSteamGenerator_1SG_Purge;
