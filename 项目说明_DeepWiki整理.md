# Simple_FingerPrint_Matching 项目说明（基于 DeepWiki 文档整理）

## 1. 文档目的

本文档基于 `参考文档/deepwiki.com_QinMoMeak_Simple_FingerPrint_Matching` 目录中的页面整理，用于快速解释本项目的组成、核心算法、数据依赖和使用方式。

## 2. 资料来源

- DeepWiki 离线页面（1.x / 2.x / 3.x 系列）
- 项目源码（用于交叉核对）
  - `AES_update/Cipher.m`
  - `AES_update/InvCipher.m`
  - `Copy_of_match.m`
  - `Copy_of_score.m`
  - `ext_finger.m`
  - `build_db.m`
  - `main_single.m`
  - `main_total.m`

## 3. 项目总体定位

该仓库是一个 MATLAB 项目，包含两套相对独立的子系统：

1. AES 加解密子系统（`AES_update/`）
2. 指纹处理与匹配子系统（特征提取 + 匹配 + 数据库）

目前两套子系统放在同一仓库中，但业务流程上没有直接耦合调用。

## 4. 目录与模块说明

- `AES_update/`：AES-128/192/256 加解密实现（含密钥扩展与 GF(2^8) 运算）
- `FExtraction/`：指纹增强相关函数（含 FFT 增强、方向滤波等）
- `database/`：与指纹数据库相关资源
- `FVC2002/`：样例/测试数据集目录
- `build_db.m`：批量提取特征并构建 `db.mat`
- `ext_finger.m`：从单张指纹图像提取细节点特征
- `Copy_of_match.m`：批量匹配流程（多候选、角度搜索）
- `Copy_of_score.m`：相似度计算函数
- `main_single.m`、`main_total.m`：示例入口脚本
- `GUI.m`、`GUI.fig`：图形化界面

## 5. AES 子系统说明

### 5.1 入口与核心流程

- 加密入口：`Cipher(key, In)`
- 解密入口：`InvCipher(key, In)`
- 共同依赖：`KeyExpansion`, `AddRoundKey`, `SubBytes/InvSubBytes`, `ShiftRows/InvShiftRows`, `MixColumns/InvMixColumns`, `xtime`

### 5.2 支持能力

- 支持三种密钥长度：AES-128 / AES-192 / AES-256
- 轮数由 `Nk + 6` 决定（对应 10/12/14 轮）
- 输入输出为 128-bit 分组的十六进制字符串

### 5.3 实现特征

- 严格按标准轮函数编排：
  - 加密：`SubBytes -> ShiftRows -> MixColumns -> AddRoundKey`
  - 解密：逆序逆变换
- 采用 `hex2dec + reshape` 的状态矩阵处理方式
- 代码注释已明确：不做输入长度健壮性校验，参数不合法会直接报错

## 6. 指纹处理与匹配子系统说明

### 6.1 特征提取主线

在 DeepWiki 文档中，特征提取管线主要包括：

1. 图像分割与归一化
2. 纹线方向估计
3. 纹线频率估计
4. 纹线增强（标准滤波路径）
5. FFT 增强（另一条增强路径）
6. 辅助函数与工具函数

源码侧对应核心入口为 `ext_finger.m`，用于生成细节点模板。

### 6.2 匹配主线

匹配由 `Copy_of_match.m` + `Copy_of_score.m` 完成：

1. 从 `db.mat` 读取模板库 `ff`
2. 通过 `Index*8-7` 定位某指纹的基准样本
3. 随机抽取多个候选进行匹配
4. 对候选进行平移/旋转搜索（暴力枚举）
5. 由 `score` 计算相似度并记录最优结果

### 6.3 关键参数（代码可见）

- 细节点过滤：`M(:,3) < 5`
- 角度搜索范围：部分候选 `-10°~10°`，部分候选 `-5°~5°`
- 相似度阈值参数（`Copy_of_score.m`）：
  - 空间距离阈值 `T = 15`
  - 角度阈值 `TT = 14`（度）
- 相似度公式：`sm = sqrt(n^2/(Count1*Count2))`

## 7. 数据文件与依赖

### 7.1 关键数据文件

- `db.mat`：指纹特征数据库（变量 `ff`）
- `angular_filters_pi_4.mat`、`angular_filters_pi_2.mat`：FFT 增强所需角度滤波器文件

### 7.2 运行依赖

- MATLAB 环境
- 图像处理相关函数（如 `bwmorph`, `imread`, `rgb2gray`）
- 需要保证数据集与 `.mat` 依赖文件在正确路径

## 8. 典型使用方式

### 8.1 构建数据库

运行 `build_db(ICount, JCount)`，批量提取图像细节点并保存为 `db.mat`。

### 8.2 单样本提取与匹配

可参考 `main_single.m`：

1. 对输入图像调用 `ext_finger`
2. 加载 `db.mat`
3. 与目标模板集合执行匹配

### 8.3 批量实验

可参考 `main_total.m`：

- 构建模板库
- 对多个样本做批量相似度计算

## 9. 当前状态与改进方向

### 9.1 当前状态

- AES 与指纹匹配子系统同仓但基本独立
- 指纹匹配以传统细节点+变换搜索为核心

### 9.2 可扩展方向

1. 用 AES 对模板库或匹配结果进行加密存储
2. 将随机候选匹配改为可复现实验模式（固定随机种子）
3. 为关键参数（阈值、角度步长、候选数）增加配置化管理
4. 增加输入校验、异常处理与自动化评测脚本

## 10. DeepWiki 页面结构索引（已整理）

- 1.x：项目概览、系统架构、数据依赖
- 2.x：AES 系统、密钥扩展、加/解密流程、GF 运算
- 3.x：指纹处理系统、特征提取流程、匹配算法与打分

---

如需进一步拆分，我可以再输出两份独立文档：

1. 仅 AES 技术说明
2. 仅指纹算法说明（含参数对照与流程图）
