# Simple_FingerPrint_Matching

指纹识别与匹配相关实验项目（MATLAB），仓库中同时包含 AES 加解密实现与指纹处理/匹配实现。

## 项目概览

本项目可分为两套相对独立的子系统：

1. AES 加解密子系统（`AES_update/`）
2. 指纹处理与匹配子系统（特征提取 + 匹配 + 数据库）

## 目录与模块

- `AES_update/`：AES-128/192/256 加解密实现（含密钥扩展与 GF(2^8) 运算）
- `FExtraction/`：指纹增强相关函数（含 FFT 增强、方向滤波等）
- `database/`：指纹数据库相关资源
- `FVC2002/`：样例/测试数据集目录
- `build_db.m`：批量提取特征并构建 `db.mat`
- `ext_finger.m`：从单张指纹图像提取细节点特征
- `Copy_of_match.m`：批量匹配流程（多候选、角度搜索）
- `Copy_of_score.m`：相似度计算
- `main_single.m`、`main_total.m`：示例入口脚本
- `GUI.m`、`GUI.fig`：图形界面

## AES 子系统

### 入口

- 加密：`Cipher(key, In)`
- 解密：`InvCipher(key, In)`

### 特点

- 支持 AES-128 / AES-192 / AES-256
- 轮数：`Nk + 6`（10/12/14 轮）
- 输入输出为 128-bit 分组十六进制字符串
- 核心变换：`SubBytes`、`ShiftRows`、`MixColumns`、`AddRoundKey` 及其逆变换
- 注：代码基本不做输入长度健壮性校验

## 指纹子系统

### 特征提取流程

1. 图像分割与归一化
2. 纹线方向估计
3. 纹线频率估计
4. 纹线增强（标准滤波路径）
5. FFT 增强路径
6. 辅助工具函数

核心入口：`ext_finger.m`

### 匹配流程

匹配由 `Copy_of_match.m` + `Copy_of_score.m` 完成：

1. 从 `db.mat` 读取模板库 `ff`
2. 通过 `Index*8-7` 定位基准样本
3. 随机抽取多个候选
4. 平移/旋转暴力搜索最优对齐
5. 调用 `score` 计算相似度

### 关键参数

- 细节点过滤：`M(:,3) < 5`
- 旋转搜索：部分候选 `-10°~10°`，部分候选 `-5°~5°`
- 相似度阈值：
  - 距离阈值 `T = 15`
  - 角度阈值 `TT = 14`（度）
- 相似度公式：`sm = sqrt(n^2/(Count1*Count2))`

## 数据与依赖

### 关键数据文件

- `db.mat`：指纹特征数据库（变量 `ff`）
- `angular_filters_pi_4.mat`、`angular_filters_pi_2.mat`：FFT 增强角度滤波器

### 运行依赖

- MATLAB
- 图像处理函数（如 `bwmorph`, `imread`, `rgb2gray`）
- 正确的数据集与 `.mat` 文件路径

## 快速使用

### 1) 构建数据库

运行 `build_db(ICount, JCount)`，提取细节点并生成 `db.mat`。

### 2) 单样本提取与匹配

参考 `main_single.m`：

1. 对输入图像调用 `ext_finger`
2. 加载 `db.mat`
3. 与模板集合执行匹配

### 3) 批量实验

参考 `main_total.m`，进行批量特征提取和相似度计算。

## 参考论文

- 论文链接（知网）：  
  [基于特征距离切尾均值的新型指纹密钥生成方法（CNKI）](https://kns.cnki.net/kcms2/article/abstract?v=adNygMj_jVCBzneA3b4yVw_uRLjq5IFnt49xTkhyQP6bsCZG226uieOkqKNxcejMtKZctuNdPbBNo3idZy6UsQLuLF_9YTqNFseL8hLlg7YhyH1UlKzQwQVipkR3k2iceEZYkdjPkrzfI4vWLQxbBCFRnIDaWEvJX15LYnI7GVQ=&uniplatform=NZKPT)
- 引用信息：  
  [1] 基于特征距离切尾均值的新型指纹密钥生成方法[J]. 网络与信息安全学报, 2023, 9(05): 178-187.

## 论文笔记

### 基本信息

- 题目：基于特征距离切尾均值的新型指纹密钥生成方法
- 期刊：网络与信息安全学报
- 年卷期页：2023, 9(05): 178-187
- 分类号：TN918.4
- 在线公开时间（知网）：2023-11-23 16:21

### 摘要要点

- 传统生物特征认证通常需要保存生物模板，存在丢失和泄露风险。
- 论文针对“不依赖智能卡、直接由指纹特征构造公钥私钥”的问题展开研究。
- 方法核心：
  - 研究稳定特征点与稳定特征距离；
  - 构造稳定特征点集合、等长稳定特征点集合、密钥特征点集合与切尾均值集合；
  - 提出基于特征距离切尾均值的指纹密钥生成方法。
- 该方法可在不存储指纹数据条件下，通过重新采集指纹重构密钥。
- 通过“哈希 + 加盐”实现指纹密钥撤销与更新。
- 实验结果：
  - 尝试 10 次重采，密钥重构成功概率为 0.7354；
  - 尝试 60 次重采，密钥重构成功概率为 0.9806。

### 关键词

- 生物特征
- 指纹特征点
- 稳定特征点
- 切尾均值
- 指纹密钥

### 基金资助

- 国家自然科学基金（61972176）
- 山东省自然科学基金（ZR2022MF264）
- （XKY1931）

## DeepWiki 文档来源

本 README 的项目说明部分来自本地离线资料：
`参考文档/deepwiki.com_QinMoMeak_Simple_FingerPrint_Matching`
