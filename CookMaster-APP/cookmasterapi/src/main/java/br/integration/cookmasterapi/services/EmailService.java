package br.integration.cookmasterapi.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendMail(String dest, String assunto, String corpo) throws Exception {
        MimeMessage mensagem = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mensagem, true);

        helper.setTo(dest);
        helper.setSubject(assunto);
        helper.setText(corpo, false);
        try {
            javaMailSender.send(mensagem);
        }catch (Exception ex){
            throw new Exception(ex.getMessage());
        }

    }

}