within ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire;
block Hysteresis

  parameter Real uMax=1 "Maximum value of the hysteresis interval";
  parameter Real uMin=0 "Minimum value of the hysteresis interval";

  Connectors.InputReal u
 annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Connectors.OutputLogical y
 annotation (Placement(transformation(extent={{100,-12},{120,8}})));
initial equation
 y.signal=if (u.signal > (uMin+uMax)/2) then false else true;

algorithm
when u.signal > uMax then
    y.signal:=false;
  end when;
when u.signal < uMin then
  y.signal:=true;
end when;

  annotation (Icon(graphics={
     Rectangle(
       extent={{-100,-100},{100,100}},
       lineColor={0,0,255},
       pattern=LinePattern.Solid,
       lineThickness=0.25,
       fillColor={255,255,255},
       fillPattern=FillPattern.Solid),
     Line(points={{-86,0},{88,0}}, color={192,192,192}),
     Line(points={{0,-78},{0,76}}, color={192,192,192}),
     Polygon(
       points={{0,88},{-5,78},{5,78},{0,88}},
       lineColor={192,192,192},
       fillColor={192,192,192},
       fillPattern=FillPattern.Solid),
     Polygon(
       points={{90,0},{80,-5},{80,5},{90,0}},
       lineColor={192,192,192},
       fillColor={192,192,192},
       fillPattern=FillPattern.Solid),
     Rectangle(
       extent={{-22,60},{26,0}},
       lineColor={0,0,0},
       fillColor={236,236,236},
       fillPattern=FillPattern.Solid),
     Line(points={{-24,32},{-22,34},{-20,32}}, color={0,0,0}),
     Line(
       points={{-2,-1},{0,1},{2,-1}},
       color={0,0,0},
       origin={26,31},
       rotation=180),
     Line(points={{0,62},{4,60},{0,58}}, color={0,0,0}),
     Line(
       points={{-2,2},{2,0},{-2,-2}},
       color={0,0,0},
       origin={4,0},
       rotation=180)}));
end Hysteresis;
