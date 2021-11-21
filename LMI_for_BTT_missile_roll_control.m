%% BTT Missile, Roll Channel
clear all; close all;

c1 = 10;
c3 = 5;

A = [-c1 0; 1 0];
B1 = [-c3; 0];
B2 = [0; 0];
C = [0 1];
D1 = 0;
D2 = 0;

yalmip('clear');
X = sdpvar(2);
W = sdpvar(1,2);
gamma = sdpvar(1);
eta = .0001;
Const = [];
Const = [Const; X>=eta*eye(size(X))];
m11 = (A*X+B1*W)'+A*X+B1*W;
m21 = B2';
m22 = -gamma*eye(1);
m31 = C*X+D1*W;
m32 = D2;
m33 = -gamma*eye(1);
m12 = m21';
m13 = m31';
m23 = m32';
mat = [m11 m12 m13; m21 m22 m23; m31 m32 m33];
Const = [Const; mat <= -eta*eye(4)];

opt=sdpsettings('solver','sedumi','verbose',0);
optimize(Const, gamma, opt);