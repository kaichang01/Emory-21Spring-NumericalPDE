%matrix setup
N = 100;
e = ones(N,1);
A = spdiags([e -2*e e],-1:1,N,N);
full(A);

%IC
y0 = e;

%interval length
T = 10;

%Initial number of steps
n = 250;

%Compute the exact solution
yex = exactSolution(A,y0);

%Vectors for storing the erros
errorAB2 = zeros(3,1);
errorAM3 = zeros(3,1);

for i = 0:2
    %adjust the # of steps
    nsteps = n*(2^i);
    %Calculate the time step size
    Dt = T/nsteps;
    %calculate the first step (Heun)
    [UH, eH] = Heun(A, y0, 1, Dt, yex);
    y1 = UH(:,2);
    
    %Use AB2
    [UAB2, eAB2] = AB2(A, y0, y1, nsteps, Dt, yex);
    errorAB2(i+1) = eAB2;
    
    %Use AB2
    [UAM3, eAM3] = AM3(A, y0, y1, nsteps, Dt, yex);
    errorAM3(i+1) = eAM3;
end



errorAB2(1)/errorAB2(2)
errorAB2(1)/errorAB2(3)

errorAM3(1)/errorAM3(2)
errorAM3(1)/errorAM3(3)



