def get_para_with_iter(num, para,interruption_type): # para = mu eta alpha lambda
    if interruption_type == "1_one_step": # "1_one_step", "2_range", "3_random"
        return f"""
% {num} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
{para}={para}_list({num});

%初值
y{num}(1)=-1;y{num}(2)=1;y{num}(3)=0.5;
u{num}(1:2)=0;
du{num}(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai{num}(1:2,1) =2;
fai{num}(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai{num}(k,1:nu)=fai{num}(k-1,1:nu)+eta*(y{num}(k)-y{num}(k-1)-fai{num}(k-1,1:nu)*du{num}(k-1,1:nu)')*du{num}(k-1,1:nu)/(mu+du{num}(k-1,1:nu)*du{num}(k-1,1:nu)');
    if (fai{num}(k,1)<10^(-5)) || ((du{num}(k-1,1:nu)*du{num}(k-1,1:nu)')^0.5<10^(-5))
        fai{num}(k,1)=0.5;
    end

    if k~=500 % one step interruption
        if nu==1
            u{num}(k) = u{num}(k-1)+rho*fai{num}(k,1)*(yd(k+1)-y{num}(k))/(lambda+fai{num}(k,1).^2);        
        else
            u{num}(k) = u{num}(k-1)+rho*fai{num}(k,1)*(yd(k+1)-y{num}(k)-fai{num}(k,2:nu)*du{num}(k-1,1:nu-1)')/(lambda+fai{num}(k,1).^2); 
        end
    else
        u{num}(k) = 0;
    end

    %model
    if k<=500
        y{num}(k+1)=y{num}(k)/(1+y{num}(k).^2)+u{num}(k)^3;
    else
        y{num}(k+1)=(y{num}(k)*y{num}(k-1)*y{num}(k-2)*u{num}(k-1)*(y{num}(k-2)-1)+a(k)*u{num}(k))/(1+y{num}(k-1)^2+y{num}(k-2)^2);    
    end
    for i=1:nu
        du{num}(k,i)=u{num}(k-i+1)-u{num}(k-i);
    end
    emax{num}(k+1)=yd(k+1)-y{num}(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"""
    elif interruption_type == "2_range": # "1_one_step", "2_range", "3_random"
        return f"""
% {num} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
{para}={para}_list({num});

%初值
y{num}(1)=-1;y{num}(2)=1;y{num}(3)=0.5;
u{num}(1:2)=0;
du{num}(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai{num}(1:2,1) =2;
fai{num}(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai{num}(k,1:nu)=fai{num}(k-1,1:nu)+eta*(y{num}(k)-y{num}(k-1)-fai{num}(k-1,1:nu)*du{num}(k-1,1:nu)')*du{num}(k-1,1:nu)/(mu+du{num}(k-1,1:nu)*du{num}(k-1,1:nu)');
    if (fai{num}(k,1)<10^(-5)) || ((du{num}(k-1,1:nu)*du{num}(k-1,1:nu)')^0.5<10^(-5))
        fai{num}(k,1)=0.5;
    end

    if k<500 || k>600 % range interruption
        if nu==1
            u{num}(k) = u{num}(k-1)+rho*fai{num}(k,1)*(yd(k+1)-y{num}(k))/(lambda+fai{num}(k,1).^2);        
        else
            u{num}(k) = u{num}(k-1)+rho*fai{num}(k,1)*(yd(k+1)-y{num}(k)-fai{num}(k,2:nu)*du{num}(k-1,1:nu-1)')/(lambda+fai{num}(k,1).^2); 
        end
    else
        u{num}(k) = 0;
    end

    %model
    if k<=500
        y{num}(k+1)=y{num}(k)/(1+y{num}(k).^2)+u{num}(k)^3;
    else
        y{num}(k+1)=(y{num}(k)*y{num}(k-1)*y{num}(k-2)*u{num}(k-1)*(y{num}(k-2)-1)+a(k)*u{num}(k))/(1+y{num}(k-1)^2+y{num}(k-2)^2);    
    end
    for i=1:nu
        du{num}(k,i)=u{num}(k-i+1)-u{num}(k-i);
    end
    emax{num}(k+1)=yd(k+1)-y{num}(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"""
    elif interruption_type == "3_random": # "1_one_step", "2_range", "3_random"
        code = str()
        if num == 1:
            code += """chance_to_be_interrupted=0.2;\n"""
        code += f"""
% {num} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%控制器参数
{para}={para}_list({num});

%初值
y{num}(1)=-1;y{num}(2)=1;y{num}(3)=0.5;
u{num}(1:2)=0;
du{num}(1:2,1:nu)=0;

I=eye(nu);
%控制器伪偏导数初值
fai{num}(1:2,1) =2;
fai{num}(1:2,2:nu)=0;
%程序循环
%for k=nu+1:N
for k=3:N
    a(k)=1+round(k/500);
    fai{num}(k,1:nu)=fai{num}(k-1,1:nu)+eta*(y{num}(k)-y{num}(k-1)-fai{num}(k-1,1:nu)*du{num}(k-1,1:nu)')*du{num}(k-1,1:nu)/(mu+du{num}(k-1,1:nu)*du{num}(k-1,1:nu)');
    if (fai{num}(k,1)<10^(-5)) || ((du{num}(k-1,1:nu)*du{num}(k-1,1:nu)')^0.5<10^(-5))
        fai{num}(k,1)=0.5;
    end"""
        if num == 1:
            code += """\nb(k)=rand();\n"""
        code += f"""

    if b(k)<chance_to_be_interrupted % random interruption
        if nu==1
            u{num}(k) = u{num}(k-1)+rho*fai{num}(k,1)*(yd(k+1)-y{num}(k))/(lambda+fai{num}(k,1).^2);        
        else
            u{num}(k) = u{num}(k-1)+rho*fai{num}(k,1)*(yd(k+1)-y{num}(k)-fai{num}(k,2:nu)*du{num}(k-1,1:nu-1)')/(lambda+fai{num}(k,1).^2); 
        end
    else
        u{num}(k) = 0;
    end

    %model
    if k<=500
        y{num}(k+1)=y{num}(k)/(1+y{num}(k).^2)+u{num}(k)^3;
    else
        y{num}(k+1)=(y{num}(k)*y{num}(k-1)*y{num}(k-2)*u{num}(k-1)*(y{num}(k-2)-1)+a(k)*u{num}(k))/(1+y{num}(k-1)^2+y{num}(k-2)^2);    
    end
    for i=1:nu
        du{num}(k,i)=u{num}(k-i+1)-u{num}(k-i);
    end
    emax{num}(k+1)=yd(k+1)-y{num}(k+1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"""
    return code

###################################################################
# 参数设置
para_var = "lambda" # para = nu eta mu rho lambda
interruption_type = "3_random" # "1_one_step", "2_range", "3_random"
if para_var == "nu":
    para_list = [0.0001, 0.01, 1, 10, 100]
elif para_var == "eta":
    para_list = [0.0001, 0.01, 1, 10, 100]
elif para_var == "mu":
    para_list = [0.0001, 0.01, 1, 10, 100]
elif para_var == "rho":
    para_list = [0.1, 0.3, 0.6, 0.9, 0.99]
elif para_var == "lambda":
    # para_list = [0.01, 0.05, 0.1, 0.5, 1]
    para_list = [0.01, 0.05, 0.1, 0.5, 1]

colors = ['b', 'r', 'm', 'g', 'c']  # 蓝色，红色，洋红色，绿色，青色
markers = ['s', '^', 'd', 'o', 'v']  # 方形，三角上标，菱形，圆形，倒三角
line_styles = ['-.', '--', ':', '-', '-.']  # 不同的线型

###################################################################
len_para_list = len(para_list)
output_dir = r"D:\_20240923_p\code\exam_2_3_3\code_" + para_var + "_" + interruption_type +".m"


if para_var=="nu":
    output_code = f"""clear all;
close all;
N=1000;

nu_list={str(para_list)};
eta=1;
mu=1;
rho=0.6;
lambda =0.1;

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
"""
elif para_var=="eta": # [0.3, 0.6, 1, 2, 5]
    output_code = f"""clear all;
close all;
N=1000;

nu=1;
eta_list={str(para_list)};
mu=1;
rho=0.6;
lambda =0.1;

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
"""
elif para_var=="mu":
    output_code = f"""clear all;
close all;
N=1000;

nu=1;
eta=1;
mu_list = {str(para_list)};
rho=0.6;
lambda =0.1;

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
"""
elif para_var=="rho":
    output_code = f"""clear all;
close all;
N=1000;

nu=1;
eta=1;
mu=1;
rho_list ={str(para_list)};
lambda =0.1;

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
"""
elif para_var=="lambda": # [0.001,0.1,1,3,5]
    output_code = f"""clear all;
close all;
N=1000;

nu=1;
eta=1;
mu=1;
rho=0.6;
lambda_list ={str(para_list)};

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
"""

for i in range(1,6):
    output_code += get_para_with_iter(i,para_var,interruption_type)


output_code += f"""clf;
mark=8;
step=20;
figure(1)
plot(0,'-k','MarkerSize',mark,'LineWidth',2);hold on;
"""

# 绘制 figure(1)
for i, (color, marker, line_style) in enumerate(zip(colors, markers, line_styles)):
    output_code += f"plot(0,'{line_style}{color}{marker}','MarkerSize',mark,'LineWidth',2);hold on;\n"

output_code += """set(gca,'LineWidth',2,'fontsize',28);
plot(yd,'k-','LineWidth',2);hold on;
"""

# 添加 y 和 y2, y3 的绘图部分
for i, (color, marker, line_style) in enumerate(zip(colors, markers, line_styles)):
    output_code += f"plot(0:k,y{i+1},'{line_style}{color}','LineWidth',2);hold on;\n"
    idx = 10 * i if i != 0 else 1
    output_code += f"plot({idx}:step:N,y{i+1}({idx}:step:N),'{color}{marker}','MarkerSize',mark,'LineWidth',2);hold on;\n"

output_code += """set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
set(gca, 'LineWidth', 2);
xlabel('时刻', 'FontSize', 20, 'FontName', 'default');ylabel('跟踪性能', 'FontSize', 20, 'FontName', 'default');
legend_labels = {'y^{{*}}(k)', """
output_code += ', '.join([f"'\\{para_var}={para_list[i]}时的输出y(k)'" for i in range(len_para_list)])
output_code += """};
legend(legend_labels, 'Interpreter', 'tex', 'FontSize', 16, 'FontName', 'default', 'Location', 'northeast');
xlim([0,1000]);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
exportgraphics(gcf, '"""
output_code += interruption_type
output_code += """_1.png', 'Resolution', 300);

figure(2)
"""

# 绘制 figure(2)
for i, (color, marker, line_style) in enumerate(zip(colors, markers, line_styles)):
    output_code += f"plot(0,'{line_style}{color}{marker}','MarkerSize',mark,'LineWidth',2);hold on;\n"

output_code += """set(gca,'LineWidth',2,'fontsize',28);
"""

# 添加 u, u2, u3 的绘图部分
for i, (color, marker, line_style) in enumerate(zip(colors, markers, line_styles)):
    output_code += f"plot(u{i+1},'{line_style}{color}','LineWidth',2);hold on;\n"
    idx = 10 * i if i != 0 else 1
    output_code += f"plot({idx}:step:N,u{i+1}({idx}:step:N),'{color}{marker}','MarkerSize',mark,'LineWidth',2);hold on;\n"

output_code += """set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
xlabel('时刻', 'FontSize', 20, 'FontName', 'default');ylabel('控制输入', 'FontSize', 20, 'FontName', 'default');
legend_labels = {"""
output_code += ', '.join([f"'\\{para_var}={para_list[i]}时的控制输入u(k)'" for i in range(len_para_list)])
output_code += """};
legend(legend_labels, 'Interpreter', 'tex', 'FontSize', 16, 'FontName', 'default', 'Location', 'northeast');
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
exportgraphics(gcf, '"""
output_code += interruption_type
output_code += """_2.png', 'Resolution', 300);

figure(3)
"""

# 绘制 figure(3)
for i, (color, marker, line_style) in enumerate(zip(colors, markers, line_styles)):
    output_code += f"plot(0,'{line_style}{color}{marker}','MarkerSize',mark,'LineWidth',2);hold on;\n"

output_code += """set(gca,'LineWidth',2,'fontsize',28);
"""

# 添加 fai, fai2, fai3 的绘图部分
for i, (color, marker, line_style) in enumerate(zip(colors, markers, line_styles)):
    output_code += f"plot(fai{i+1},'{line_style}{color}','LineWidth',2);hold on;\n"
    idx = 10 * i if i != 0 else 1
    output_code += f"plot({idx}:step:N,fai{i+1}({idx}:step:N),'{color}{marker}','MarkerSize',mark,'LineWidth',2);hold on;\n"

output_code += """set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
xlabel('时刻', 'FontSize', 20, 'FontName', 'default');ylabel('PPD估计值', 'FontSize', 20, 'FontName', 'default');
legend_labels = {"""
output_code += ', '.join([f"'\\{para_var}={para_list[i]}时PPD的估计值'" for i in range(len_para_list)])
output_code += """};
legend(legend_labels, 'Interpreter', 'tex', 'FontSize', 16, 'FontName', 'default', 'Location', 'northeast');
set(gcf, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
exportgraphics(gcf, '"""
output_code += interruption_type
output_code += """_3.png', 'Resolution', 300);
"""


with open(output_dir, "w", encoding="UTF-8") as writer:
    writer.write(output_code)

print(f"code saved to dir: {output_dir}")
