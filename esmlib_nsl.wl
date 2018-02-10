(* ::Package:: *)

IFPlot[sol_]:=Module[{vars},
vars=sol[[All,1]];
Plot[
	#[t]&/@(vars/.sol),
	Prepend[(vars[[1]]/.sol)["Domain"][[1]],t],
	PlotLegends->vars]
]


makeDimensionless[Xs_,t_,T_]:=
(*Xs input is of form {{x,X,\[Beta]},{\[Theta],\[Theta],\[Beta]2},...}*)
Join[
Table[X[[1]][t]:>Evaluate[1/X[[3]] X[[2]][T]], {X,Xs}],

Table[Derivative[n_][X[[1]]][t]:>Evaluate[\[Alpha]^n/X[[3]] Derivative[n][X[[2]]][T]],{X,Xs}]];


assumeReal[x_]:=x/.{Abs[thing___]^2:>thing^2}
