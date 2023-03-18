within ThermoSysPro.ConvectedQuantities.Substances;
package Amines
  extends None(redeclare type Concentrations = enumeration(
        ETA "",
        Mo "",
        NH3 "",
        Hz ""),
        redeclare block PhasesSeparation = PhasesSeparation_internal,
        redeclare block pH = pH_internal);

  block pKa

    import      ThermoSysPro.Units.SI;

    output Real y[Concentrations];
    input SI.Temperature T;

  equation

    y[Concentrations.ETA] = 2253.4/T+8.84717-2.805*log10(T);
    y[Concentrations.Mo] = 1288.74/T+18.4914-5.78762*log10(T);
    y[Concentrations.NH3] = 10.0106-0.0329798*(T-273.15)+(7.86471e-5)*(T-273.15)^2-(968690e-8)*(T-273.15)^3;
    y[Concentrations.Hz] = 2884.84/T-14.2584+5.13337*log10(T);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end pKa;

  block D

    import      ThermoSysPro.Units.SI;

    output Real y[Concentrations];
    input SI.Temperature T;

  equation

    log10(y[Concentrations.ETA]) = -2.62907+0.020081*(T-273.15)-(7.23142e-5)*(T-273.15)^2+(1.36266e-7)*(T-273.15)^3-(1.29098e-10)*(T-273.15)^4+(3.92105e-15)*(T-273.15)^5;
    log10(y[Concentrations.Mo]) = -1.20011+0.013048*(T-273.15)-(6.38358e-5)*(T-273.15)^2+(2.51951e-7)*(T-273.15)^3-(6.56075e-10)*(T-273.15)^4+(6.80014e-13)*(T-273.15)^5;
    log10(y[Concentrations.NH3]) = 1.62079-0.00605403*(T-273.15)+(2.16642e-5)*(T-273.15)^2-(7.75081e-7)*(T-273.15)^3+(1.54369e-10)*(T-273.15)^4-(1.65523e-13)*(T-273.15)^5;
    log10(y[Concentrations.Hz]) = -2.50803+0.01222*(T-273.15)-(4.65786e-5)*(T-273.15)^2+(2.44393e-7)*(T-273.15)^3-(8.02417e-10)*(T-273.15)^4+(9.80658e-13)*(T-273.15)^5;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end D;

  block PhasesSeparation_internal

    import      ThermoSysPro.Units.SI;

    input SI.Temperature T "Fluid Temperature";
    input SI.Density rho_liquidPhase "Fluid Density";
    input Real x "Title";
    input Real SubC[Amines.Concentrations] "Total Species Concentrations";

    output Real Cl[Amines.Concentrations] "Species Concentration in the Liquid Phase";
    output Real Cg[Amines.Concentrations] "Species Concentration in the Gas Phase";

    Real OHm(start=1.e-7) "";
    Real Kb[Amines.Concentrations] "";
    Real Kw "";
    Real rel_density "Relative density compared to 25 °C";

    Amines.pKa pKa(T=T);
    Amines.D D(T=T);

  equation

    //Density as ratio of water dentity @ T and water density @ 25°C
    rel_density = rho_liquidPhase / 999.975;

    Kw=10^(-4.098+(-3245.2/T)+((2.2362e5/(T*T)))+((-3.984e7)/(T*T*T))+((13.957+(-1262.3/T)+((8.564e5)/(T*T)))*log10(rel_density)));

    for s in Amines.Concentrations loop
      Kb[s] = 10^(pKa.y[s]+log10(Kw));
      Cl[s] = SubC[s]/(1+x*(D.y[s]/(1+Kb[s]/OHm)-1));
      Cg[s] = Cl[s]*D.y[s]/(1+Kb[s]/OHm);
    end for;

    OHm = (sum(Kb.*Cl)+Kw)^(1/2);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                            Ellipse(
            extent={{-60,60},{60,-60}},
            lineColor={0,0,255},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{60,0},{58,14},{54,26},{48,36},{38,46},{26,54},{14,58},{0,60},
                {0,0},{60,0}},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Polygon(
            points={{-60,0},{-58,14},{-54,26},{-48,36},{-38,46},{-26,54},{-14,58},
                {0,60},{0,0},{-60,0}},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Ellipse(
            extent={{-42,28},{-26,12}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-18,48},{-6,36}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,24},{16,4}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{26,34},{42,18}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{24,-12},{40,-28}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-40,-22},{-24,-38}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{10,-36},{22,-48}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,-4},{2,-26}},
            lineColor={28,108,200},
            fillColor={85,255,255},
            fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end PhasesSeparation_internal;

  block pH_internal

    import      ThermoSysPro.Units.SI;

    input SI.Temperature T "Fluid Temperature";
    input SI.Density rho_liquidPhase "Fluid Density";
    input Real x "Title";
    input Real SubC[Amines.Concentrations] "Total Species Concentrations";

    output Real pH "";

    Real OHm(start=1.e-7) = phasesSeparation.OHm "";
    Real Kw = phasesSeparation.Kw "";
    Real rel_density = phasesSeparation.rel_density "Relative density compared to 25 °C";

    PhasesSeparation phasesSeparation(T=T, rho_liquidPhase=rho_liquidPhase, x=x, SubC=SubC)
      annotation (Placement(transformation(extent={{-32,-32},{32,32}})));

  equation

    OHm = 10^(pH+log10(Kw));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end pH_internal;
end Amines;
