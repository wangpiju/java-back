package com.hs3.admin.utils.googleOTP;

/**
 * program: java-back
 * des:
 * author: Terra
 * create: 2018-06-09 11:33
 **/

import org.junit.Test;

/**
 * 身份认证测试
 *
 * @author yangbo
 * @version 创建时间：2017年8月14日 上午11:09:23
 */
public class AuthTest {
    //当测试authTest时候，把genSecretTest生成的secret值赋值给它
    private static String secret = "RDCW2ETMKHYSLGPV";

    @Test
    public void genSecretTest() {// 生成密钥
        secret = GoogleAuthenticator.generateSecretKey();
        // 把这个qrcode生成二维码，用google身份验证器扫描二维码就能添加成功
        String qrcode = GoogleAuthenticator.getQRBarcode("troytest", secret);
        System.out.println("qrcode:" + qrcode + ",key:" + secret);
    }

    /**
     * 对app的随机生成的code,输入并验证
     */
    @Test
    public void verifyTest() {
        long code = 585254;
        long t = System.currentTimeMillis();
        GoogleAuthenticator ga = new GoogleAuthenticator();
        ga.setWindowSize(1);
        boolean r = ga.check_code(secret, code, t);
        System.out.println("检查code是否正确？" + r);
    }
}
