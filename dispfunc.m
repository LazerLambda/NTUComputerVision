function [map] = dispfunc(Ir, Il, Dx, Dy)
    
    Ir = uint32(Ir);
    Il = uint32(Il);
      
    [syr sxr] = size(Ir);
   
    
    map = ones([syr sxr]);
    
    for i = (1):(syr - Dy - 1)
        for j = (1):(sxr - Dx - 1)
         
            T = Il((i):(i+Dy-1), (j):(j + Dx-1));
            Tsq = T.^2;
            
            % limit bounds
            limitright = j + 15;
            if limitright >= sxr - Dx
                limitright = sxr - Dx;
            end

            limitleft = j-15;
            if 0 >= limitleft
                limitleft = j;
            end 
            
            % init witnesses
            min = intmax;
            index = 0;


            for k = limitleft:(limitright - 1)
                I = Ir((i):(i+Dy-1), (k):(k + Dx-1));
                Isq = I.^2;
                a = conv2(Isq, ones(Dx, Dy), 'same');
                b = conv2(Tsq, ones(Dx, Dy), 'same');
                %T = rot90(T);
                c = conv2(I, rot90(rot90(T)), 'same');
                
                res = a(6,6) + b(6,6) - 2*c(6,6);
                
                if res < min
                    min = res;
                    index = k;
                end
            end
            map(i,j) = index- j;
        end
    end
           
    
    % on the scanline, collect the min value init with first value and get
    % always the smaller value
end

