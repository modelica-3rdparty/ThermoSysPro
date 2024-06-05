within ThermoSysPro.Examples.SimpleExamples;
model TestWirelessSensor
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom1(
    m=rampe_down.y.signal,
    m_nominal=1e10,
    max_range=1e10,
    min_range=1e8,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-30,80},{10,120}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom2(
    m=rampe_down.y.signal,
    m_nominal=1e9,
    max_range=8e9,
    min_range=2e8,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{30,80},{70,120}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom3(
    m=rampe_down.y.signal,
    m_nominal=1e8,
    max_range=1e10,
    min_range=1e8,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-80,80},{-40,120}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom4(
    m=rampe_down.y.signal,
    m_nominal=1000,
    max_range=8e9,
    min_range=2e8,
    ValidityRange=false)
    annotation (Placement(transformation(extent={{80,80},{120,120}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe_down(
    Starttime=10,
    Duration=100,
    Initialvalue=1e8,
    Finalvalue=1e10) annotation (Placement(transformation(extent={{-120,90},{
            -100,110}},
                      rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom5(
    m=rampe_up.y.signal,
    m_nominal=1e10,
    max_range=1e10,
    min_range=1e8,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-30,30},{10,70}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom6(
    m=rampe_up.y.signal,
    m_nominal=1e9,
    max_range=8e9,
    min_range=2e8,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{30,30},{70,70}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom7(
    m=rampe_up.y.signal,
    m_nominal=1e8,
    max_range=1e10,
    min_range=1e8,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-80,30},{-40,70}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom8(
    m=rampe_up.y.signal,
    m_nominal=1000,
    max_range=8e9,
    min_range=2e8,
    ValidityRange=false)
    annotation (Placement(transformation(extent={{80,30},{120,70}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe_up(
    Starttime=10,
    Duration=100,
    Initialvalue=1e10,
    Finalvalue=1e8) annotation (Placement(transformation(extent={{-120,40},{
            -100,60}},
                  rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom9(
    m=rampe2_down.y.signal,
    m_nominal=10,
    max_range=10,
    min_range=0,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-28,-20},{12,20}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom10(
    m=rampe2_down.y.signal,
    m_nominal=7,
    max_range=9,
    min_range=1,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{30,-20},{70,20}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom11(
    m=rampe2_down.y.signal,
    m_nominal=0,
    max_range=10,
    min_range=0,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom12(
    m=rampe2_down.y.signal,
    m_nominal=1000,
    max_range=9,
    min_range=1,
    ValidityRange=false)
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe2_down(
    Starttime=10,
    Duration=100,
    Initialvalue=0,
    Finalvalue=10)   annotation (Placement(transformation(extent={{-120,-10},{
            -100,10}},rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe2_up(
    Starttime=10,
    Duration=100,
    Initialvalue=10,
    Finalvalue=0) annotation (Placement(transformation(extent={{-120,-60},{-100,
            -40}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom13(
    m=rampe2_up.y.signal,
    m_nominal=10,
    max_range=10,
    min_range=0,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-28,-70},{12,-30}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom14(
    m=rampe2_up.y.signal,
    m_nominal=7,
    max_range=9,
    min_range=1,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{30,-70},{70,-30}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom15(
    m=rampe2_up.y.signal,
    m_nominal=0,
    max_range=10,
    min_range=0,
    ValidityRange=true)
    annotation (Placement(transformation(extent={{-80,-70},{-40,-30}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.WirelessSensor wirelessSensor_nom16(
    m=rampe2_up.y.signal,
    m_nominal=1000,
    max_range=9,
    min_range=1,
    ValidityRange=false)
    annotation (Placement(transformation(extent={{80,-70},{120,-30}})));
 annotation (experiment(StopTime=200, __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-120,-120},{120,120}}),
         graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}),
            graphics={Text(
          extent={{-120,-80},{120,-120}},
          textColor={28,108,200},
          textString="Test made for the WirelessSensor
Different orders of magnitude have been tested for ramp 
to see if no issues are found at the the threshold T>T_max or T<T_min in scalarToColor_validityRange function")}));
end TestWirelessSensor;
