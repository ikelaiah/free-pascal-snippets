program solve_ode_sys;

{$mode objfpc}{$H+}{$J-}

uses
  typ,  // Includes necessary types for operations with numlib.
  ode;  // Provides the ODE solver used in the program.

const
  ae = 1e-5;  // Absolute error tolerance for the ODE solver.

  // This procedure defines the system of differential equations to solve.
  // It takes the independent variable 'x' and the current values 'y' and computes the derivatives 'f(x,y)'.
  procedure f(x: ArbFloat; var y, fxy: ArbFloat);
  var
    // These arrays represent the system of equations.
    _y: array[1..2] of ArbFloat absolute y;
    // Current y values (dependent variables).
    _fxy: array[1..2] of ArbFloat absolute fxy;    // Corresponding derivatives (dy/dx).
  begin
    // First equation of the system: dy1/dx = 2*x*y1 + y2
    _fxy[1] := 2 * x * _y[1] + _y[2];
    // Second equation of the system: dy2/dx = -y1 + 2*x*y2
    _fxy[2] := -_y[1] + 2 * x * _y[2];
  end;

  // This function returns the exact solution for y1 at a given 'x'.
  function exact1(x: ArbFloat): ArbFloat;
  begin
    Result := exp(x * x) * sin(x);  // Exact solution for y1 = exp(x^2) * sin(x)
  end;

  // This function returns the exact solution for y2 at a given 'x'.
  function exact2(x: ArbFloat): ArbFloat;
  begin
    Result := exp(x * x) * cos(x);  // Exact solution for y2 = exp(x^2) * cos(x)
  end;

var
  a, b, d: ArbFloat; // 'a' and 'b' are the interval bounds, 'd' is the step size.
  ya, yb: array[1..2] of ArbFloat;  // Arrays to hold y values at 'a' and 'b'.
  term, i, n: ArbInt;
  // 'term' stores the error code, 'i' is the loop index, 'n' is the number of steps.

begin
  // Set initial values.
  a := 0.0;        // Start point for x.
  b := 0.1;        // Initial end point for x.
  d := b - a;      // Step size (difference between 'a' and 'b').
  ya[1] := 0.0;    // Initial condition for y1 (y1(0) = 0).
  ya[2] := 1.0;    // Initial condition for y2 (y2(0) = 1).
  n := 10;         // Number of steps.

  // Print table headers for output.
  WriteLn('x': 12, 'y[1]': 12, 'y[2]': 12, 'exact[1]': 12, 'exact[2]': 12, 'error code': 17);
  WriteLn;

  // Output the initial conditions at x = 0.
  WriteLn(a: 12: 5, ya[1]: 12: 5, ya[2]: 12: 5, exact1(a): 12: 5, exact2(a): 12: 5, '-': 17);

  // Loop through 'n' steps to solve the system over each interval.
  for i := 1 to n do
  begin
    // Call the ODE solver (odeiv2) to compute yb at x = b.
    // 'f' is the function defining the system of ODEs, 'a' is the start point,
    // 'ya[1]' are the initial y-values, 'b' is the end point,
    // 'yb[1]' will store the computed y-values at 'b',
    // '2' indicates the system size (two equations), 'ae' is the accuracy, and 'term' stores the error code.
    odeiv2(@f, a, ya[1], b, yb[1], 2, ae, term);

    // Output the results at each step: x = b, y1(b), y2(b), exact solutions, and error code.
    WriteLn(b: 12: 5, yb[1]: 12: 5, yb[2]: 12: 5, exact1(b): 12: 5, exact2(b): 12: 5, term: 17);

    // Update the values for the next iteration.
    a := b;         // Move to the next interval starting from the current 'b'.
    ya[1] := yb[1]; // Set ya to the computed yb for the next step.
    ya[2] := yb[2];
    b := b + d;     // Increment 'b' by the step size 'd'.
  end;

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.
