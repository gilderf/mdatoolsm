function varargout = plotyexpvar(obj, varargin)
   i = find(strcmp(varargin, 'Type'), 1);
   if ~isempty(i)
      type = varargin{i + 1};
      varargin(i:i+1) = [];
   else
      type = 'line';
   end
   
   [mr, varargin] = getarg(varargin, 'Marker');
   if isempty(mr)
      mr = '.';
   end   

   c = mdadata.getmycolors(3);
   
   plotData = obj.calres.ydecomp.variance(:, 1);
   plotData.colNames = {'cal'};

   if ~isempty(obj.cvres)
      plotData = [plotData obj.cvres.ydecomp.variance(:, 1)];
      plotData(:, end).colNames = {'cv'};
   else
      c(2, :) = [];
   end   
   
   if ~isempty(obj.testres) 
      plotData = [plotData obj.testres.ydecomp.variance(:, 1)];
      plotData(:, end).colNames = {'test'};
   else
      c(end, :) = [];
   end   
      
   if strcmp(type, 'bar')   
      h = gbar(plotData', varargin{:}, 'FaceColor', c);
   elseif strcmp(type, 'line')   
      h = gplot(plotData', varargin{:}, 'Marker', mr, 'Color', c);
   else
      error('Wrong plot type!');
   end
   
   if nargout > 0
      varargout{1} = h.plot;
   end   
   title('Y explained variance')
end
