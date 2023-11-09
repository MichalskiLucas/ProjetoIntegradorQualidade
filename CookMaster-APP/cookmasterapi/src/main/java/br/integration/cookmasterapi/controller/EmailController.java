package br.integration.cookmasterapi.controller;

import br.integration.cookmasterapi.services.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import javax.mail.MessagingException;

@Controller
public class EmailController {

    @Autowired
    private EmailService emailService;

    @PostMapping("/email")
    public void enviarEmail() throws Exception {
        emailService.sendMail("kedssy533779@gmail.com", "Assunto do e-mail", "Corpo do e-mail");
    }
}

