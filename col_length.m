function [C,indexA ] = col_length(A,con,normA)


[m, n] = size(A)  ; % the size of the input matrix A.

%------- Compute the normalized leverage scores of eqn. 3 of [1]. ---------
pi = zeros(1, n) ; 
for j=1:n
    pi(j) =  (norm(A(:,j))^2) / (normA) ;
end
%--------------------------------------------------------------------------

%---------------- randomized column selection -----------------------------

% indexA = []; % indexA is initially empty. 
indexA = randsample(1:n,con,true,pi);
% % 
% % for j=1:n    % for every column of A
% % 
% %     % the j-th column of A is selected with probability prob_j.
% %     prob_j = min([1 pi(j)]);  % find the minimum of 1 and  c*pi(j)
% %     prob_j = prob_j(1);         % resolve the case where 1 = c*pi(j)
% % 
% %     if prob_j==1             % if prob_j=1 select the j-th column of A
% %         indexA = [indexA j];
% %     elseif  prob_j > rand    % if prob_j<1, generate a random number rand in [0,1] and then 
% %         indexA = [indexA j]; % if prob_j > rand, select the j-th column of A 
% %     end
% % 
% % end
    C = A(:, indexA);
end