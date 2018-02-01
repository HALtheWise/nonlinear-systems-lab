(* ::Package:: *)

IFPlot[sol_]:=Module[{vars},
vars=sol[[All,1]];
Plot[
	#[t]&/@(vars/.sol),
	Prepend[(vars[[1]]/.sol)["Domain"][[1]],t],
	PlotLegends->vars]
]


makeDimensionless[x_,X_,t_,T_]:={x[t]:>1/\[Beta] X[T],Derivative[n_][x][t]:>\[Alpha]^n/\[Beta] Derivative[n][X][T]};
