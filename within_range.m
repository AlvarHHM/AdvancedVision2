%%
% Function which says whether A is within range of B
%%

function boolean = within_range(alpha, beta, A, B)

    index = size(A);
    for i = 1:index
        if (A(i)<B(i)+alpha) && (A(i)>B(i)-beta)
            boolean = true;
        else
            boolean = false;
        end
    end  
end