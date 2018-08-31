%Definitions
clc
clear all;
close all;
xm=300;
ym=300;
sink.x=0.5*xm;
sink.y=0.5*ym;
sink.x=100;
sink.y=75;
n=200;
p=0.1;
Eo=0.5;
INFINITY=999999999;



for i=1:1:n
    S(i).xd=rand(1,1)*xm;
    XR(i)=S(i).xd;
    S(i).yd=rand(1,1)*ym;
    YR(i)=S(i).yd;
    S(i).G=0;
    S(i).type='N';
    S(i).E=Eo;
    S(i).ENERGY=0;
end
plot(XR,YR,'*');
hold on;

S(n+1).xd=sink.x
S(n+1).yd=sink.y

%Cluster head selection
r=1;
cluster=1;
for i=1:1:n
   if(S(i).E>0)
     temp_rand=rand;     
        if(temp_rand <=0.2)
            S(i).type = 'C';
            S(i).G = round(1/p)-1;
            C(cluster).xd = S(i).xd;
            C(cluster).yd = S(i).yd;
   
            distance=sqrt((S(i).xd-(S(n+1).xd))^2 + (S(i).yd-(S(n+1).yd))^2);
            
            C(cluster).distance = distance;
            C(cluster).id = i;
            X(cluster)=S(i).xd;
            Y(cluster)=S(i).yd;
            cluster=cluster+1;
            distanceBroad = sqrt(xm*xm+ym*ym);

        end     
   end 
end
plot(X,Y,'r+');



%Voroni Formation
[vx,vy]=voronoi(X(:),Y(:));
hold on;
voronoi(X,Y);




%Node choosing heads
for i=1:1:n
   if (S(i).type=='N' && S(i).E>0) 
    % min_dis = sqrt( (S(i).xd-S(n+1).xd)^2 + (S(i).yd-S(n+1).yd)^2 );%
     min_dis = INFINITY;
     if(cluster-1>=1)
         min_dis_cluster = 1;
        
         for c = 1:1:cluster-1 %
            %temp = min(min_dis,sqrt( (S(i).xd - C(c).xd)^2 + (S(i).yd - C(c).yd)^2 ) );
            temp = sqrt((S(i).xd - C(c).xd)^2 + (S(i).yd - C(c).yd)^2);
            if (temp<min_dis)
                min_dis = temp;
                min_dis_cluster = c;
            end
         end       
         S(i).min_dis = min_dis;
         S(i).min_dis_cluster = min_dis_cluster;
     
     end
  end
end

