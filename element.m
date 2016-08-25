classdef element
%descripton....TODO

    properties
    % define the properties of the class here, (like fields of a struct)
        number;
        nodes;
        
%         hour;
%         day;
%         month;
%         year;
    end
   
     methods
     % methods, including the constructor are defined in this block
        function obj = element(number,nodes)
        % class constructor
            if(nargin > 0)
                 obj.number=number;
                 obj.nodes=nodes;
                 
            end
        end
        
        % methods, including the constructor are defined in this block
        function obj = printNodes(obj)
            for i=1:4
               obj.nodes
            end
        end
    end
end
