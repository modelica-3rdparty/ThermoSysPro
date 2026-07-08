within ThermoSysPro.UsersGuide;

class ReleaseNotes "Release notes"
  class Version_2_0 "Version 2.0"
    annotation(
      Documentation(info = "
Version 4.1 (January 24, 2011)    
 This is the first open source release of the library.    


      "),
      Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100.0, -100.0}, {100.0, 100.0}}), Polygon(origin = {-4.167, -15.0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
  end Version_2_0;

  class Version_3_0 "Version 3.0"
    annotation(
      Documentation(info = "
Version 4.1 (December 20, 2011)    
ThermoSysPro modifications from version 2.0     
Analytic jacobian is added to the library.    
The examples package is added to the library.    
Other modifications:    

Component MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases     

o   Introduction of two new parameters z1 and z2     
o   Correction of parameters TwoPhaseFlowPipe.z1, and TwoPhaseFlowPipe.z2. Old values z1 = 0 and z2 = 0. New values z1 = z1 and z2 = z2.     

Package Units     

o   New unit AbsoluteTemperature     
o   New unit DifferentialTemperature     
o   New unit  AbsolutePressure     
o   New unit DifferentialPressure     
o   New unit SpecificEnthalpy     

Component  ElectroMechanics.Machines.SynchronousMotor     

o   Parameter permanent_meca changed to steady_stae_mech     
o   Parameter Coupleur changed to mech_coupling     

Component  ElectroMechanics.Machines.Shaft     

o   Parameter permanent_meca changed to steady_state_mech     

Package Properties.WaterSteam.IF97_packages     

o   New IF97 package with analytic jacobian     
o   Removal of the old IF97 package     

Function IF97.SplineUtilities.Modelica_Interpolation.Bspline1D.parametrization     

o   arccos changed to acos     

Component WaterSteam.PressureLosses.CheckValve     

o   Adding modifier (start=false, fixed=true) for variables touvert and tferme.     

Component WaterSteam.PressureLosses.IdealCheckValve     

o   Adding modifier (start=false, fixed=true) for variables touvert and tferme.     

Component FlueGases.PressureLosses.CheckValve     

o   Adding modifier (start=false, fixed=true) for variables touvert and tferme.     

Component WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe     

o   Adding a default value to parameter T0     

Package Functions     

o   New function SmoothStep     
o   New function SmoothSign     
o   New function SmoothAbs     

Component WaterSteam.Machines.DynamicCentrifugalPump     

o   Use of function SmoothSign for computation of Cf.     
o   New parameter continuous_flow_reversal     

Component WaterSteam.Machines.StaticCentrifugalPump     

o   New parameter continuous_flow_reversal     
o   Removing input commandePompe     
o   Input VRotation changed to rpm_or_mpower     
o   New parameter MPower     
o   New parameter fixed_rot_or_power     
o   Efficiency characteristics rh=a*Qv^2/R^2 + b*Qv/R + c changed to rh=a*Qv*abs(Qv)/R^2+b*Qv/R+c to ensure convergence for fixed mechanical power     

Component WaterSteam.PressureLoses.LumpedStraightPipe <======     

o   Modification of default value of parameter rugosrel. Old value: 0, new value 0.0001.     
o   Adding initial equation:  der(Q) = 0     

Component WaterSteam.Volumes.TwoPhaseVolume     

o   Property prol is computed at pressure (P + Pfond)/2 instead of P.     

Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe     

o   New parameter dpfCorr     
o   New parameter hcCorr     

Component WaterSteam.HeatExchanger.DynamicTwoPhaseFlowPipe     

o   New parameter dpfCorr     

Component Thermal.HeatTransfer.HeatExchangerWall     

o   Wall 1 becomes the internal wall     
o   Wall 2 becomes the external wall     
o   Heat flux through external wall is corrected     

Component WaterSteam.HeatExchanger. StaticWaterWaterExchangerDTorWorEff     

o   Modification of the power equation for case exchanger_type = 3.     

Component WaterSteam.HeatExchanger.TemperatureWallBoiler     

o   Modification of some parameter default values     

Function Correlations.PressureLosses.WBWaterSteamPressureLosses     

o   b0 is bounded to 0.01     
o   Gm^2 is replaced by Gm*abs(Gm)     
o   Adding equation dpa := 0.     

Function Properties.WaterSteam.BaseIF97.Basic.psat     

o   Calls to LogVariable removed.     

Component Combustion.BoundaryConditions.FuelSourcePQ     

o   Handling of input signals corrected.     

Component MultiFluid.HeatExchangers.NTUTechnologicalExchangerWaterSteamFlueGases     

o   Correction of computation of variable mono.     

Component WaterSteam.Machines.StodolaTurbine     

o   Modification of default value for parameter Qmax. Old Value=15, new value=1.     

Function Correlation.Thermal.WBInternalHeatTransferCoefficient     

o   New function.     

Component WaterSteamHeatExchangers.TemperatureWallBoiler     

o   Call to WBInternalHeatTransferCoefficient instead of separate calls to WBInternalOnePhaseFlowHeatTransferCoefficient and WBInternalTwoPhaseFlowHeatTransferCoefficient     

Component WaterSteam.Junctions.Mixer3     

o   Bug correction: flow from port Ce3 added in mass balance and energy balance equations.     

Component WaterSteam.BoundaryConditions.RefQ     

o   Correction of default value for Q0. Old value=1.e5. New value=10.     

Component WaterSteam.Junctions.StaticDrum     

o   Correction of comment for parameter x     
o   Adding thermal connector Cth and variable T     
o   Modification of energy balance equation to take into account external energy supply.     
o   Adding equation Cth.T = T;     

Package Thermal.BoundaryConditions     

o   New component HeatSink     

Package WaterSteam.BoundaryConditions     

o   New components PlugA, PlugB     

Component InstrumentationAndControl.Blocks.Tables.Table1D     

o   Dymola specific function Interpolate is replaced by ThermoSysPro.Functions.LinearInterpolation.     

Component InstrumentationAndControl.Blocks.Tables.Table1DTemps     

o   Dymola specific function Interpolate is replaced by ThermoSysPro.Functions.LinearInterpolation.     

Function Functions.LinearInterpolation     

o   Output DeltaYX is removed.     
o   Function calls Functions.LinearInterpolation_i, which returns DelTaXY.     

Function Functions.TableLinearInterpolation     

o   Outputs DeltaYX and DeltaYP are removed.     
o   Function calls Functions.TableLinearInterpolation_i, which returns DelTaXY and DeltaYP.     

Function Correlations.Misc..WBCorrectiveDiameterCoefficient     

o   Unused variables Z1, Z2 are removed.     

Function Correlations.Thermal.WBCrossedCurrentConvectiveHeatTranferCoefficient     

o   Unused variables Z1, Z2 are removed.     

Function Correlations.Thermal.WBLongitudinalCurrentConvectiveHeatTranferCoefficient     

o   Unused variables Z1, Z2 are removed.     

Function Correlations.Thermal.WBRadiativeHeatTranferCoefficient     

o   Unused variables Z1, Z2, Z3, Z4 are removed.     

Component WaterSteam.Machines.SteamEngine     

o   Function Interpolation is replaced by function LinearInterpolation     

Component WaterSteam.PressureLosses.ControlValve     

o   Function Interpolation is replaced by function LinearInterpolation     

Component WaterSteam.PressureLosses.DynamicCheckValve     

o   Function Interpolation is replaced by function LinearInterpolation     

Component WaterSteam.PressureLosses.DynamicReliefValve     

o   Function Interpolation is replaced by function LinearInterpolation     

Component FlueGases.PressureLosses.ControlValve     

o   Function Interpolation is replaced by function LinearInterpolation     

Package Functions     

o   Function Interpolation is removed. One should use function LinearInterpolation instead.     

Package Units     

o   Unit RotationVelocity renamed to AngularVelocity_rpm     
      "),
      Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100.0, -100.0}, {100.0, 100.0}}), Polygon(origin = {-4.167, -15.0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
  end Version_3_0;

  class Version_3_1 "Version 3.1"
    annotation(
      Documentation(info = "
Version 4.1 (June 12, 2014)     
ThermoSysPro modifications from version 3.0     
      

Component ElectroMechanics.BoundaryConditions.SourceMechanicalPower     

o   Equation M.Ctr*abs(M.w) = IPower.signal is replaced by M.Ctr*M.w = IPower.signal     

Package ElectroMechanics.BoundaryConditions     

o   New component SourceAngularVelocity     
o   New component SourceTorque     

Package Function     

o   New function SmoothMax     
o   New function SmoothMin     
o   New function SmoothCond     

Package WaterSteam.Machines     

o   New component CentrifugalPump, replaces old components DynamicCentrifugalPump and StaticCentrifugalPump.     

Component WaterSteam.Machines.DynamicCentrifugalPump     

o   Obsolete component, replaced by component CentrifugalPump     

Component WaterSteam.Machines.StaticCentrifugalPump     

o   Obsolete component, replaced by component CentrifugalPump     

Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe     

o   Parameter dynamic_energy_balance is removed     

Component WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe     

o   Parameter dynamic_energy_balance is removed     

Function Properties.CH3F5.CH3F5_Ps     

o   Correction of the computation of x for one-phase flow (liquid or vapor)     

Component WaterSteam.HeatExchangers.SimpleDynamicCondenser     

o   Correction of the computation of Wout     

Component WaterSteam.Volumes.TwoPhaseVolume     

o   Correction: Cl.a = true (instead of Cl.b = true)     

Component FlueGases.HeatExchangers. StaticWallFlueGasesExchanger     

o   Correction of the computation of dW[i]     

Component WaterSteam.Junctions.SteamDryer     

o   Correction of the mass balance equations     

Component Combustion.CombustionChambers.GenericCombustionChamber     

o   Correction of the computation of HFuel     

Component Combustion.CombustionChambers.GTCombustionChamber     

o   Correction of the computation of HFuel     

Component WaterSteam.Volumes.Tank     

o   Parameter k is replaced by parameters ke1, ke2, ks1, ks2.     

Function Functions. LinearInterpolation_i     

o   Correction of the computation of Y     

Package Units     

o   Unit SpecificEnthalpy removed     
o   Unit AbsolutePressure removed     
o   Unit AbsoluteTemperature removed     

Package WaterSteam.HeatExchangers     

o   New component DynamicWaterHeating     

Package WaterSteam.Volumes     

o   New component TwoPhaseCavity     

Component FlueGases.Volumes.VolumeATh     

o   Modifier stateSelect removed     

Component FlueGases.Volumes.VolumeBTh     

o   Modifier stateSelect removed     

Component FlueGases.Volumes.VolumeCTh     

o   Modifier stateSelect removed     

Component FlueGases.Volumes.VolumeDTh     

o   Modifier stateSelect removed     

Component WaterSteam.Machines.Compressor     

o   xm is bounded by min value 0.01 (to avoid division by zero in case fluid is water, which should not happen in a compressor).     

Component FlueGases.PressureLosses.SingularPressureLoss     

o   Default value for parameter K changed to 1.e-3.     

Component WaterSteam.Machines.StodolaTurbine     

o   Extension of the computation of xm and Q for supercritical regimes.     

Component WaterSteam.Boilers.ElectricBoiler     

o   Correction of the computation of deltaH.     

Component WaterSteam.Machines.StaticCentrifugalPump     

o   Value of rh is changed. Old value: 0.05 - New value: 0.20     

Component WaterSolution.Machines.StaticCentrifugalPump     

o   Value of rh is changed. Old value: 0.05 - New value: 0.20     

Component FlueGases.Machines.StaticFan     

o   Value of rh is changed. Old value: 0.05 - New value: 0.20     

Package Functions     

o   New functions SplineInterpolation and TableSplineInterpolation     
o   New package Utilities     
o   Function LinearInterpolation_i  moved to Functions.Utilities     
o   Function TableLinearInterpolation_i  moved to Functions.Utilities     

Package Functions.Utilities     

o   New function CubicHermite     

Block InstrumentationAndControl.Blocks.Table.Table1D     

o   New interpolating option: spline interpolation     

Block InstrumentationAndControl.Blocks.Table.Table1DTemps     

o   New interpolating option: spline interpolation     

Block InstrumentationAndControl.Blocks.Table.Table2D     

o   New interpolating option: spline interpolation     

Component WaterSteam.Machines.CentrifugalPump     

o   Linear interpolation of F and G is replaced by spline interpolation     

Component FlueGases.PressureLosses.ControlValve     

o   New interpolating option: spline interpolation     

Component WaterSteam.PressureLosses.ControlValve     

o   New interpolating option: spline interpolation     

Component WaterSteam.PressureLosses.DynamicCheckValve     

o   New interpolating option: spline interpolation     

Component WaterSteam.PressureLosses.DynamicReliefValve     

o   New interpolating option: spline interpolation     

Component WaterSteam.Machines.SteamEngine     

o   New interpolating option: spline interpolation     

Function Correlation.Misc.WBCorrectiveDiameterCoefficient     

o   New interpolating option: spline interpolation     

Function Correlation.Thermal. WBCrossedCurrentConvectiveHeatTransferCoefficient     

o   New interpolating option: spline interpolation     

Function Correlation.Thermal. WBLongitudinalCurrentConvectiveHeatTransferCoefficient     

o   New interpolating option: spline interpolation     

Function Correlation.Thermal. WBRadiativeHeatTransferCoefficient     

o   New interpolating option: spline interpolation     

Component WaterSteam.HeatExchangers.TwoPhaseFlowPipe     

o   Adding noEvent for the computation of hi and Xtt     

Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe     

o   Extension of the computation of hc for laminar flows     

Component WaterSteam.HeatExchangers.DynamicWaterWaterExchanger     

o   Modification of the computation of DPc and DPf. Previous  version: DPc[i] = p_Kc*Qc[i]^2/(2*rhoc[i]); DPf[i] = p_Kf*Qf[i]^2/(2*rhof[i]); New version: DPc[i] = p_Kc*Qc[i]^2/rhoc[i]; DPf[i] = p_Kf*Qf[i]^2/rhof[i];     

Component WaterSteam.HeatExchangers.StaticWaterWaterExchanger     

o   Modification of the computation of DPc and DPf. Previous  version: DPc[i] = p_Kc*Qc[i]^2/(2*rhoc[i]); DPf[i] = p_Kf*Qf[i]^2/(2*rhof[i]); New version: DPc[i] = p_Kc*Qc[i]^2/rhoc[i]; DPf[i] = p_Kf*Qf[i]^2/rhof[i];     

Component WaterSteam.HeatExchangers.NTUWaterHeating     

o   Modification of the value of eps. Previous value:  1. New value: 1.e-3.     

Component WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe     

o   Adaptation to the supercritical phase     

Package WaterSteam.HeatExchangers     

o   New component DynamicWaterHeatingOnePipe     

Package Thermal.HeatTransfer     

o   New component HeatExchangerWallCounterFlow     

Package Properties     

o   New package MoltenSalt     
o   New package Oil_TherminolVP1     

Component WaterSteam.Machines.StodolaTurbine     

o   Equation xm = if noEvent(Ps > pcrit) then 1 else (1 + pros1.x)/2; is replaced by xm = 1;     

Component WaterSteam.Volumes.Tank     

o   New parameter dynamic_mass_balance     
o   New equation A*(pro.ddph*der(P) + pro.ddhp*der(h))*z + A*rho*der(z) = BQ; when dynamic_mass_balance = true     
      "),
      Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100.0, -100.0}, {100.0, 100.0}}), Polygon(origin = {-4.167, -15.0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
  end Version_3_1;

  class Version_3_2 "Version 3.2"
    annotation(
      Documentation(info = "
Version 4.1 (August 5, 2020)     
ThermoSysPro modifications from version 3.1    
      

Package Correlations     

o   New Function Misc.Function_FM     
o   New Function Thermal.Function_U1     

Component FlueGases.HeatExchangers.StaticFluegasesFluegasesExchangerKS     

o   Introduction of connector  InputReal Kcorr and variable Kcor     

Components FlueGases.Volumes.VolumesATh; VolumesBTh; VolumesCTh and VolumesDTh     

o   New  parameters hr, Xco20, Xh2o0, Xo20, Xso20     
o   Initial section is modified to replace state variable T with state variable h.     
o   Equation V*(ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2)*der(P) + ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2)*cp*der(T)) = BQ; is replaced by V*(ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2)*der(P) + ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2)*der(h - Xh2o*hr)) = BQ;     
o   Equation V*((h*ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2) - 1)*der(P) + (h*ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2) + rho)*cp*der(T)) = BH; is replaced by  V*(((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2) - 1)*der(P) + ((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2) + rho)*der(h - Xh2o*hr)) = BH;     

Component FlueGases.Volumes.VolumesATh  and VolumesBTh     

o   Equation BH = Ce1.Q*he1 + Ce2.Q*he2 - Cs1.Q*hs1 - Cs2.Q*hs2 + Cth.W;  is replaced by  BH = Ce1.Q*(he1 - Ce1.Xh2o*hr) + Ce2.Q*(he2 - Ce2.Xh2o*hr) - Cs1.Q*(hs1 - Cs1.Xh2o*hr) - Cs2.Q*(hs2 - Cs2.Xh2o*hr) + Cth.W;     

Component FlueGases.Volumes.VolumesCTh     

o   Equation BH = Ce1.Q*he1 + Ce2.Q*he2 + Ce3.Q*he3 - Cs.Q*hs + Cth.W; is replaced by  BH = Ce1.Q*(he1 - Ce1.Xh2o*hr) + Ce2.Q*(he2 - Ce2.Xh2o*hr) + Ce3.Q*(he3 - Ce3.Xh2o*hr) - Cs.Q*(hs - Cs.Xh2o*hr) + Cth.W;     

Component FlueGases.Volumes.VolumesDTh     

o   Equation BH = Ce1.Q*he1 – Cs1.Q*hs1 – Cs2.Q*hs2 – Cs3.Q*hs3 + Cth.W; is replaced by   BH = Ce.Q*(he - Ce.Xh2o*hr) - Cs1.Q*(hs1 - Cs1.Xh2o*hr) - Cs2.Q*(hs2 - Cs2.Xh2o*hr) - Cs3.Q*(hs3 - Cs3.Xh2o*hr) + Cth.W;     

Component FlueGases.Junctions.Mixer2     

o   Equation 0 = Ce1.Q*he1 + Ce2.Q*he2 - Cs.Q*hs; is replaced by   0 = Ce1.Q*(he1 - Ce1.Xh2o*hr) + Ce2.Q*(he2 - Ce2.Xh2o*hr) - Cs.Q*(hs - Cs.Xh2o*hr);     

Component FlueGases.Junctions.Splitter2     

o   Equation 0 = Ce.Q*he - Cs1.Q*hs1 - Cs2.Q*hs2 is replaced by   0 = Ce.Q*(he - Ce.Xh2o*hr) - Cs1.Q*(hs1 - Cs1.Xh2o*hr) - Cs2.Q*(hs2 - Cs2.Xh2o*hr);     

Package FlueGases.BoundaryConditions     

o   New component SourceQX     

Package Combustion.CombustionChambers     

o   New component GenericCombustion1D     

Component CombustionChamber.GenericCombustion     

o   Equations  Hfuel = Cpfuel*Tfuel;    Hcv = Cpcd*Tsf;  Hbf = Cpcd*Tbf;  are replaced by Hfuel = Cpfuel*(Tfuel - 273.16);  Hcv = Cpcd*(Tsf - 273.16);  Hbf = Cpcd*(Tbf - 273.16);     

Component Combustion.CombustionChambers.GTCombustionChamber     

o   Equation Wcpat = Qea*XQat*(Hiscpat - Hecpat)/eta_isc; is replaced by Wcpat = Qea*XQat*(Hiscpat - Hecpat)*eta_isc;     

Component Combustion.BoundaryConditions.FuelSourcePQ     

o  Parameter rho=0.72 is replaced by rho=720     

Package Properties     

o   New Package Properties.DryAirIdealGas     
o   New Package Properties.SolarSalt     
o   Package Properties.Fluid has been completed     
o   Package Properties.C3H3F5 has been completed     
o   Package Properties.MoltenSalt has been completed     
o   Package Properties.Oil_TherminolVP1 has been completed     

Package ThermoSysPro     

o   New package Solar     

Package Thermal.HeatTransfer     

o   New component HeatExchangerWallWithLosses     

Package WaterSteam.HeatExchangers     

o   New component CoolingTower     
o   New component DynamicOnePhaseFlowShell     
o   New component DynamicTwoPhaseFlowRiser     
o   New component DynamicTwoFlowHeatExchangerShell     
o   New component SteamGenerator_1SG     
o   New component SteamGenerator_4SG     
o   New component StaticCondenserHEI     
o   Component TemperatureWallBoiler is removed     

Package WaterSteam.Volumes     

o   New component TwoPhaseCavityOnePipe     

Component WaterSteam.Machines.StodolaTurbine     

o   New parameter eta_is_wet(start=0.83) \"Isentropic efficiency for wet steam\"; eta_is_wet = xm*eta_is;     

Component WaterSteam.PressureLosses.LumpedStraightPipe     

o   New parameter ntubes     
o   Equation mu = ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho, T); is replaced by mu = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(Pm,h,fluid,mode, 0.1,0.1,0.1,0); for fluid = 2     

Component WaterSteam.PressureLosses.InvSingularPressureLoss     

o   Equation deltaP = if noEvent(abs(Q) < Qeps) then 1.e10 else K*ThermoSysPro.Functions.ThermoSquare(Q, eps)/rho; is replaced by deltaP = if noEvent(abs(Q) < Qeps) then 1.e-10 else K*ThermoSysPro.Functions.ThermoSquare(Q, eps)/rho;     

Component WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe     

o   Equation hc[i] = hcCorr*3.66*k[i]/D;  is replaced by hc[i] = hcCorr*k[i]/D*max(4.36,0.023*Re1[i]^0.8*Pr[i]^0.4);     
o   Equation dpa[i] = noEvent(Q[i]* abs Q[i]*(1/rhoc[i + 1] - 1/rhoc[i])/A^2); is replaced by dpa[i] = Q[i]^2*(1/rhoc[i + 1] - 1/rhoc[i])/A^2;     

Component WaterSteam. HeatExchangers.DynamicTwoPhaseFlowPipe     

o   Equation xv1[i] = pro1[i].x); is replaced by xv1[i] = if noEvent((P[i+1] > pcrit) or (T1[i] > Tcrit)) then 1 else pro1[i].x;     
o   Equation xv2[i] = pro2[i].x); is replaced by xv2[i] = if noEvent(((P[i] + P[i + 1])/2 > pcrit) or (T2[i] > Tcrit)) then 1 else pro2[i].x;     
o   Equation dpa[i] = noEvent(Q[i]* abs Q[i]*(1/rhoc[i + 1] - 1/rhoc[i])/A^2); is replaced by dpa[i] = Q[i]^2*(1/rhoc[i + 1] - 1/rhoc[i])/A^2;     

Component WaterSteam.Junctions.SteamExtractionSplitter     

o   parameter Real alpha = 1 \"Steam extraction rate (0 <= alpha <= 1)\"; is replaced by  parameter Real alpha = 1 \"Vapor mass fraction at the extraction/Vapor mass fraction at the inlet (0 <= alpha <= 1)\";     
o   Equation x_ex = 1 - alpha*(1 - proe.x); is replaced by x_ex = alpha*proe.x;     

Component WaterSteam.HeatExchangers.DynamicCondenser     

o   Component is replaced by new component DynamicCondenser (from SEPTEN)     

Component  WaterSteam.HeatExchangers.DynamicWaterWaterExchanger     

o   Equation DPc[i] = p_Kc*Qc[i]^2/rhoc[i]; is replaced by DPc[i] = p_Kc*ThermoSysPro.Functions.ThermoSquare(Qc[i], 1.e-3)/rhoc[i];     
o   Equation DPf[i] = p_Kf*Qf[i]^2/rhof[i]; is replaced  by DPf[i] = p_Kf*ThermoSysPro.Functions.ThermoSquare(Qf[i], 1.e-3)/rhof[i];     

Component  WaterSteam.HeatExchangers.StaticWaterWaterExchanger     

o   Equation DPc = p_Kc*Qc^2/rhoc; is replaced by DPc = p_Kc*ThermoSysPro.Functions.ThermoSquare(Qc, 1.e-3)/rhoc;     
o   Equation DPf = p_Kf*Qf^2/rhof; is replaced by DPf = p_Kf*ThermoSysPro.Functions.ThermoSquare(Qf, 1.e-3)/rhof;     

Component  WaterSteam.Machines.CentrifugalPump     

o   parameter Integer mode=0  is replaced by  parameter Integer mode=1     
o  Equation Wm - Wr = 0; is replaced by Cm - Cr = 0;      

Component  WaterSteam.Machines.DynamicCentrifugalPump     

o   parameter Integer mode=0  is replaced by  parameter Integer mode=1      

Component  WaterSteam.Machines.StaticCentrifugalPump     

o   parameter Integer mode=0  is replaced by  parameter Integer mode=1      

Component  WaterSteam.Volumes.Pressurizer     

o   parameter Real Cevap=0.5 \"Evaporation coefficient\";  is replaced by  parameter Real Cevap=0.1 \"Evaporation coefficient\";     
o   Equation  Qcond = noEvent(Ccond*rhov*Vv*(hvs - hv)/(hvs - hls) + (Cas.Q*(hls - Cas.h) + 0.5*(Wpv + abs(Wpv)) + Wlv)/(hv - hls));  is replaced by  Qcond = Ccond*rhov*Vv*(hvs - hv)/(hvs - hls);     

Component  WaterSteam.Junctions.SteamDryer     

o   Deleted variable Real eta1(start=1.0) \"Vapor mass fraction at outlet (0 < eta <= 1)\";     
o    Deleted equation eta1 = noEvent(max(xe, eta));     
o   Equation Csl.h_vol = noEvent(if  (Csv.Q > 0) then (if (xe > 0) then lsat1.h else Cev.h) else  h); is replaced by Csl.h_vol = noEvent(if (xe > 0) then lsat1.h else Cev.h);     
o   Equation Csv.Q = Cev.Q*xe/eta1; is replaced by Csv.Q = noEvent(if (xe > 0) then Cev.Q*(1-eta*(1-xe)) else 0);     

Component  MultiFluids.Machines.AlternatingEngine     

o   Parameter Pnom is removed     
o   Constant Real Gamma=1.3333 \"Flue gases gamma = Cp/Cv\"; is replaced by parameter Real Gamma=1.3333 \"Flue gases gamma = Cp/Cv\";     
o   Equation Tfcb = (Wcomb - Wpth_ref)/ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pfcp, (Tfcp + Tfcb)/2, XsfCO2, XsfH2O, XsfO2, XsfSO2)/0.75/Qsf + Tfcp;  is replaced by  Tfcb = Wcomb/ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pfcp, (Tfcp + Tfcb)/2, XsfCO2, XsfH2O, XsfO2, XsfSO2)/Qsf + Tfcp;     
o   Equation   if (Wmeca > (Pnom * 0.5)) then Welec = (Wmeca*Relec)*(0.0479*Cosphi + 0.952);   else Welec = (Wmeca*Relec_red)*(0.0479*Cosphi + 0.952);   end if;  is replaced by Welec = Wmeca*Relec;     

Component  MultiFluids.Boilers.FossilFuelBoiler     

o   New parameter  Boiler_efficiency_type = 1 \"1: Taking into account LHV only - 2: Using the total incoming power\";     
o   Equation eta_boil = 100*Wboil/Wfuel; is replaced by if (Boiler_efficiency_type == 1) then eta_boil = 100*Wboil/Wfuel; else eta_boil = 100*Wboil/Wtot; end if;     

Package InstrumentationAndControl     

o   New block AdaptorForFMU.AdaptorModelicaTSP     
o   New block AdaptorForFMU.AdaptorTSPModelica     

All components MultiFluids.Machines.CHPEngine*     

o   Parameter Pnom is removed     

Component FlueGases.HeatExchangers.StaticWallFlueGasesExchanger     

o   Parameter Surf_ext becomes public     

Component WaterSteam.HeatExchangers.DynamicOnePhaseFlow     

o   Component is renamed as DynamicOnePhaseFlowShell     

Component WaterSteam.Volumes.Tank     

o   The momentum balance equations are replaced by singular pressure losses that represent the pressure losses at the orifices.     

Component WaterSteam.PressureLosses.DynamicCheckValve     

o   The spring torque Cr is removed.     

Component WaterSteam.PressureLosses.DynamicReliefValve     

o   Component is completely modified (previous version was incorrect).     
      "),
      Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100.0, -100.0}, {100.0, 100.0}}), Polygon(origin = {-4.167, -15.0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
  end Version_3_2;

  class Version_4_0 "Version 4.0"
    annotation(
      Documentation(info = "
Version 4.0 (June 7, 2022)     
ThermoSysPro modifications from version 3.2    
      

New package ThermoSysPro.Fluid     

o   Package utilizes new fluid connectors that can handle all fluids in package ThermoSysPro.Properties.     
o   Package handles thermal diffusion as a new option.     
o   Package replaces packages ThermoSysPro.Combustion, ThermoSysPro.FlueGases, ThermoSysPro.MultiFluids, ThermoSysPro.WaterSolution and ThermoSysPro.WaterSteam.     

Component ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterWaterExchanger     

o   Equation DPc[i] = p_Kc*ThermoSysPro.Functions.ThermoSquare(Qc[i], 1.e-3)/rhoc[i];  is replaced by  DPc[i] = p_Kc*Qc[i]^2/rhoc[i];     
o   Equation DPf[i] = p_Kf*ThermoSysPro.Functions.ThermoSquare(Qf[i], 1.e-3)/rhof[i];  is replaced by  DPf[i] = p_Kf*Qf[i]^2/rhof[i];     

Component ThermoSysPro.WaterSteam.HeatExchangers.StaticWaterWaterExchanger     

o   Equation DPc = p_Kc*ThermoSysPro.Functions.ThermoSquare(Qc, 1.e-3)/rhoc;  is replaced by  DPc = p_Kc*Qc^2/rhoc;     
o   Equation DPf = p_Kf*ThermoSysPro.Functions.ThermoSquare(Qf, 1.e-3)/rhof;  is replaced by  DPf = p_Kf*Qf^2/rhof;     

Component ThermoSysPro.Fluid.Machines.Generator_11     

o   Component is duplicated in package ThermoSysPro.ElectroMechanics.Machines for package Fluid     

Component ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall    

o   New option: dynamic_energy_balance     

Package ThermoSysPro.Units    

o   New package: SI that duplicates package Modelica.SIunits     
o   New package: nonSI     
o   New package: xSI     

All components in package ThermoSysPro    

o   ThermoSysPro.Units.xSI.DifferentialTemperature is replaced by ThermoSysPro.Units.SI.TemperatureDifference     
o   ThermoSysPro.Units.xSI.DifferentialPressure is replaced by ThermoSysPro.Units.SI.PressureDifference     
o   ThermoSysPro.Units.xSI.MassFraction is replaced by ThermoSysPro.Units.SI.MassFraction     
o   All references to Modelica.SIunits are replaced by references to ThermoSysPro.Units     

Component ThermoSysPro.Solar.Collectors.FresnelField     

o   New parameter: Lc    
o   New parameter: trackingFactor    
o   New parameter: thermalLossPhy    
o   Equation KL = cos(pi*thetaL/180)*(1 - h*tan(pi*thetaL/180)/L); is replaced by KL = cos(pi*thetaL/180)*(1 - h*tan(pi*thetaL/180)/Lc);    
o   Equation dQloss[i] = pi*D*L/Ns*(0.5*F12*Emi*5.67e-8*(T[i]^4 - (0.0552*T0^(1.5))^4) + hc*(T[i] - T0)); is replaced by dQloss[i] = if thermalLossPhy then pi*D*L/Ns*(0.5*F12*Emi*5.67e-8*(T[i]^4 - (0.0552*T0^(1.5))^4) + hc*(T[i] - T0)) else L/Ns*(A1*deltaT[i] + A2*deltaT[i]^2);    
      "),
      Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100.0, -100.0}, {100.0, 100.0}}), Polygon(origin = {-4.167, -15.0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
  end Version_4_0;

  class Version_4_1 "Version 4.1"
    annotation(
      Documentation(info = "
Version 4.1 (November 6, 2024)     
ThermoSysPro modifications from version 4.0     
      

New features:     

o   Added a new sensor component ThermoSysPro/InstrumentationAndControl/Blocks/Sources/WirelessSensor to show Real values which can then be connected to ThermoSysPro signal components (featuring a color scale).    
o   Added the NuclearCore package.    
o Added a new I&C component for Hysteresis effect : ThermoSysPro/InstrumentationAndControl/Blocks/NonLineaire/Hysteresis.    
o   Added a pressure output signal in ThermoSysPro/WaterSteam/Volumes/Pressurizer.    

Fixes:     

o   Modification of ntubes from Integer to Real in Fluid/PressureLosses/LumpedStraightPipe, WaterSteam/HeatExchangers/DynamicOnePhaseFlowPipe and WaterSteam/PressureLosses/LumpedStraightPipe to allow equivalent geometries.    
o  Some Xh2o concentrations in some diphasic components in the Fluid package were set to 1 whereas it should have been 0.    
o EndOfLines are now set to     
 and not to Windows'EOLs     
\\r, so that all OS can modify the library (.gitattributes added to the git library)    
      "),
      Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100.0, -100.0}, {100.0, 100.0}}), Polygon(origin = {-4.167, -15.0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
  end Version_4_1;
  annotation(
    Documentation(info = "
Release notes    

This section summarizes the changes that have been performed    
on the ThermoSysPro library.    

    "),
    Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100.0, -100.0}, {100.0, 100.0}}), Polygon(origin = {-4.167, -15.0}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
end ReleaseNotes;