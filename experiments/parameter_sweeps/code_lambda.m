clear all;
close all;
N=1000;

nu=1;
eta=1;
mu=1;
rou=0.6;
lambda_list =[0.01, 0.05, 0.1, 0.5, 1];

%期望值
for k=1:N+1
    if k<=300
        yd(k)=0.5*(-1)^round(k/100);
    else
        if k<=700
            yd(k)=0.5*sin(k*pi/100)+0.3*cos(k*pi/50);
        else
            yd(k)=0.5*(-1)^round(k/100);
        end
     end
end

% 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
lambda=lambda_list(1);

%初值
y1(1)=-1;y1(2)=1;y1(3)=0.5;
u1(1:2)=0;
du1(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai1(1:2,1) =2;
fai1(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai1(k,1:nu)=fai1(k-1,1:nu)+eta*(y1(k)-y1(k-1)-fai1(k-1,1:nu)*du1(k-1,1:nu)')*du1(k-1,1:nu)/(mu+du1(k-1,1:nu)*du1(k-1,1:nu)');
    if (fai1(k,1)<10^(-5)) || ((du1(k-1,1:nu)*du1(k-1,1:nu)')^0.5<10^(-5))
        fai1(k,1)=0.5;
    end
    if nu==1
        u1(k) = u1(k-1)+rou*fai1(k,1)*(yd(k+1)-y1(k))/(lambda+fai1(k,1).^2);        
    else
        u1(k) = u1(k-1)+rou*fai1(k,1)*(yd(k+1)-y1(k)-fai1(k,2:nu)*du1(k-1,1:nu-1)')/(lambda+fai1(k,1).^2); 
    end
    %model
    if k<=500
        y1(k+1)=y1(k)/(1+y1(k).^2)+u1(k)^3;
    else
        y1(k+1)=(y1(k)*y1(k-1)*y1(k-2)*u1(k-1)*(y1(k-2)-1)+a(k)*u1(k))/(1+y1(k-1)^2+y1(k-2)^2);    
    end
    for i=1:nu
        du1(k,i)=u1(k-i+1)-u1(k-i);
    end
    emax1(k+1)=yd(k+1)-y1(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
lambda=lambda_list(2);

%初值
y2(1)=-1;y2(2)=1;y2(3)=0.5;
u2(1:2)=0;
du2(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai2(1:2,1) =2;
fai2(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai2(k,1:nu)=fai2(k-1,1:nu)+eta*(y2(k)-y2(k-1)-fai2(k-1,1:nu)*du2(k-1,1:nu)')*du2(k-1,1:nu)/(mu+du2(k-1,1:nu)*du2(k-1,1:nu)');
    if (fai2(k,1)<10^(-5)) || ((du2(k-1,1:nu)*du2(k-1,1:nu)')^0.5<10^(-5))
        fai2(k,1)=0.5;
    end
    if nu==1
        u2(k) = u2(k-1)+rou*fai2(k,1)*(yd(k+1)-y2(k))/(lambda+fai2(k,1).^2);        
    else
        u2(k) = u2(k-1)+rou*fai2(k,1)*(yd(k+1)-y2(k)-fai2(k,2:nu)*du2(k-1,1:nu-1)')/(lambda+fai2(k,1).^2); 
    end
    %model
    if k<=500
        y2(k+1)=y2(k)/(1+y2(k).^2)+u2(k)^3;
    else
        y2(k+1)=(y2(k)*y2(k-1)*y2(k-2)*u2(k-1)*(y2(k-2)-1)+a(k)*u2(k))/(1+y2(k-1)^2+y2(k-2)^2);    
    end
    for i=1:nu
        du2(k,i)=u2(k-i+1)-u2(k-i);
    end
    emax2(k+1)=yd(k+1)-y2(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
lambda=lambda_list(3);

%初值
y3(1)=-1;y3(2)=1;y3(3)=0.5;
u3(1:2)=0;
du3(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai3(1:2,1) =2;
fai3(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai3(k,1:nu)=fai3(k-1,1:nu)+eta*(y3(k)-y3(k-1)-fai3(k-1,1:nu)*du3(k-1,1:nu)')*du3(k-1,1:nu)/(mu+du3(k-1,1:nu)*du3(k-1,1:nu)');
    if (fai3(k,1)<10^(-5)) || ((du3(k-1,1:nu)*du3(k-1,1:nu)')^0.5<10^(-5))
        fai3(k,1)=0.5;
    end
    if nu==1
        u3(k) = u3(k-1)+rou*fai3(k,1)*(yd(k+1)-y3(k))/(lambda+fai3(k,1).^2);        
    else
        u3(k) = u3(k-1)+rou*fai3(k,1)*(yd(k+1)-y3(k)-fai3(k,2:nu)*du3(k-1,1:nu-1)')/(lambda+fai3(k,1).^2); 
    end
    %model
    if k<=500
        y3(k+1)=y3(k)/(1+y3(k).^2)+u3(k)^3;
    else
        y3(k+1)=(y3(k)*y3(k-1)*y3(k-2)*u3(k-1)*(y3(k-2)-1)+a(k)*u3(k))/(1+y3(k-1)^2+y3(k-2)^2);    
    end
    for i=1:nu
        du3(k,i)=u3(k-i+1)-u3(k-i);
    end
    emax3(k+1)=yd(k+1)-y3(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
lambda=lambda_list(4);

%初值
y4(1)=-1;y4(2)=1;y4(3)=0.5;
u4(1:2)=0;
du4(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai4(1:2,1) =2;
fai4(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai4(k,1:nu)=fai4(k-1,1:nu)+eta*(y4(k)-y4(k-1)-fai4(k-1,1:nu)*du4(k-1,1:nu)')*du4(k-1,1:nu)/(mu+du4(k-1,1:nu)*du4(k-1,1:nu)');
    if (fai4(k,1)<10^(-5)) || ((du4(k-1,1:nu)*du4(k-1,1:nu)')^0.5<10^(-5))
        fai4(k,1)=0.5;
    end
    if nu==1
        u4(k) = u4(k-1)+rou*fai4(k,1)*(yd(k+1)-y4(k))/(lambda+fai4(k,1).^2);        
    else
        u4(k) = u4(k-1)+rou*fai4(k,1)*(yd(k+1)-y4(k)-fai4(k,2:nu)*du4(k-1,1:nu-1)')/(lambda+fai4(k,1).^2); 
    end
    %model
    if k<=500
        y4(k+1)=y4(k)/(1+y4(k).^2)+u4(k)^3;
    else
        y4(k+1)=(y4(k)*y4(k-1)*y4(k-2)*u4(k-1)*(y4(k-2)-1)+a(k)*u4(k))/(1+y4(k-1)^2+y4(k-2)^2);    
    end
    for i=1:nu
        du4(k,i)=u4(k-i+1)-u4(k-i);
    end
    emax4(k+1)=yd(k+1)-y4(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
lambda=lambda_list(5);

%初值
y5(1)=-1;y5(2)=1;y5(3)=0.5;
u5(1:2)=0;
du5(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai5(1:2,1) =2;
fai5(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai5(k,1:nu)=fai5(k-1,1:nu)+eta*(y5(k)-y5(k-1)-fai5(k-1,1:nu)*du5(k-1,1:nu)')*du5(k-1,1:nu)/(mu+du5(k-1,1:nu)*du5(k-1,1:nu)');
    if (fai5(k,1)<10^(-5)) || ((du5(k-1,1:nu)*du5(k-1,1:nu)')^0.5<10^(-5))
        fai5(k,1)=0.5;
    end
    if nu==1
        u5(k) = u5(k-1)+rou*fai5(k,1)*(yd(k+1)-y5(k))/(lambda+fai5(k,1).^2);        
    else
        u5(k) = u5(k-1)+rou*fai5(k,1)*(yd(k+1)-y5(k)-fai5(k,2:nu)*du5(k-1,1:nu-1)')/(lambda+fai5(k,1).^2); 
    end
    %model
    if k<=500
        y5(k+1)=y5(k)/(1+y5(k).^2)+u5(k)^3;
    else
        y5(k+1)=(y5(k)*y5(k-1)*y5(k-2)*u5(k-1)*(y5(k-2)-1)+a(k)*u5(k))/(1+y5(k-1)^2+y5(k-2)^2);    
    end
    for i=1:nu
        du5(k,i)=u5(k-i+1)-u5(k-i);
    end
    emax5(k+1)=yd(k+1)-y5(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf;
mark=8;
step=20;
figure(1)
plot(0,'-k','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'-.bs','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'--r^','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,':md','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'-go','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'-.cv','MarkerSize',mark,'LineWidth',2);hold on;
set(gca,'LineWidth',2,'fontsize',28);
plot(yd,'k-','LineWidth',2);hold on;
plot(0:k,y1,'-.b','LineWidth',2);hold on;
plot(1:step:N,y1(1:step:N),'bs','MarkerSize',mark,'LineWidth',2);hold on;
plot(0:k,y2,'--r','LineWidth',2);hold on;
plot(10:step:N,y2(10:step:N),'r^','MarkerSize',mark,'LineWidth',2);hold on;
plot(0:k,y3,':m','LineWidth',2);hold on;
plot(20:step:N,y3(20:step:N),'md','MarkerSize',mark,'LineWidth',2);hold on;
plot(0:k,y4,'-g','LineWidth',2);hold on;
plot(30:step:N,y4(30:step:N),'go','MarkerSize',mark,'LineWidth',2);hold on;
plot(0:k,y5,'-.c','LineWidth',2);hold on;
plot(40:step:N,y5(40:step:N),'cv','MarkerSize',mark,'LineWidth',2);hold on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
set(gca, 'LineWidth', 2);
xlabel('时刻', 'FontSize', 20, 'FontName', 'default');ylabel('跟踪性能', 'FontSize', 20, 'FontName', 'default');
legend_labels = {'y^{{*}}(k)', '\lambda=0.01时的输出y(k)', '\lambda=0.05时的输出y(k)', '\lambda=0.1时的输出y(k)', '\lambda=0.5时的输出y(k)', '\lambda=1时的输出y(k)'};
legend(legend_labels, 'Interpreter', 'tex', 'FontSize', 16, 'FontName', 'default', 'Location', 'northeast');
xlim([0,1000]);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
exportgraphics(gcf, 'lambda_1.png', 'Resolution', 300);

figure(2)
plot(0,'-.bs','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'--r^','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,':md','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'-go','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'-.cv','MarkerSize',mark,'LineWidth',2);hold on;
set(gca,'LineWidth',2,'fontsize',28);
plot(u1,'-.b','LineWidth',2);hold on;
plot(1:step:N,u1(1:step:N),'bs','MarkerSize',mark,'LineWidth',2);hold on;
plot(u2,'--r','LineWidth',2);hold on;
plot(10:step:N,u2(10:step:N),'r^','MarkerSize',mark,'LineWidth',2);hold on;
plot(u3,':m','LineWidth',2);hold on;
plot(20:step:N,u3(20:step:N),'md','MarkerSize',mark,'LineWidth',2);hold on;
plot(u4,'-g','LineWidth',2);hold on;
plot(30:step:N,u4(30:step:N),'go','MarkerSize',mark,'LineWidth',2);hold on;
plot(u5,'-.c','LineWidth',2);hold on;
plot(40:step:N,u5(40:step:N),'cv','MarkerSize',mark,'LineWidth',2);hold on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
set(gca, 'LineWidth', 2);
xlabel('时刻', 'FontSize', 20, 'FontName', 'default');ylabel('控制输入', 'FontSize', 20, 'FontName', 'default');
legend_labels = {'\lambda=0.01时的控制输入u(k)', '\lambda=0.05时的控制输入u(k)', '\lambda=0.1时的控制输入u(k)', '\lambda=0.5时的控制输入u(k)', '\lambda=1时的控制输入u(k)'};
legend(legend_labels, 'Interpreter', 'tex', 'FontSize', 16, 'FontName', 'default', 'Location', 'northeast');
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
exportgraphics(gcf, 'lambda_2.png', 'Resolution', 300);

figure(3)
plot(0,'-.bs','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'--r^','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,':md','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'-go','MarkerSize',mark,'LineWidth',2);hold on;
plot(0,'-.cv','MarkerSize',mark,'LineWidth',2);hold on;
set(gca,'LineWidth',2,'fontsize',28);
plot(fai1,'-.b','LineWidth',2);hold on;
plot(1:step:N,fai1(1:step:N),'bs','MarkerSize',mark,'LineWidth',2);hold on;
plot(fai2,'--r','LineWidth',2);hold on;
plot(10:step:N,fai2(10:step:N),'r^','MarkerSize',mark,'LineWidth',2);hold on;
plot(fai3,':m','LineWidth',2);hold on;
plot(20:step:N,fai3(20:step:N),'md','MarkerSize',mark,'LineWidth',2);hold on;
plot(fai4,'-g','LineWidth',2);hold on;
plot(30:step:N,fai4(30:step:N),'go','MarkerSize',mark,'LineWidth',2);hold on;
plot(fai5,'-.c','LineWidth',2);hold on;
plot(40:step:N,fai5(40:step:N),'cv','MarkerSize',mark,'LineWidth',2);hold on;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
set(gca, 'LineWidth', 2);
xlabel('时刻', 'FontSize', 20, 'FontName', 'default');ylabel('PPD估计值', 'FontSize', 20, 'FontName', 'default');
legend_labels = {'\lambda=0.01时PPD的估计值', '\lambda=0.05时PPD的估计值', '\lambda=0.1时PPD的估计值', '\lambda=0.5时PPD的估计值', '\lambda=1时PPD的估计值'};
legend(legend_labels, 'Interpreter', 'tex', 'FontSize', 16, 'FontName', 'default', 'Location', 'northeast');
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
exportgraphics(gcf, 'lambda_3.png', 'Resolution', 300);
