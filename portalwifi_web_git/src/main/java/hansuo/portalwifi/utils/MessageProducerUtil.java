package hansuo.portalwifi.utils;

import java.io.IOException;
import java.util.concurrent.TimeoutException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.retry.backoff.ExponentialBackOffPolicy;
import org.springframework.retry.support.RetryTemplate;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;

@Component
public class MessageProducerUtil {

	private static final Logger logger = LoggerFactory.getLogger(MessageProducerUtil.class);

	private static boolean hasInit = false;

	@Value("${spring.rabbitmq.host}")
	public String host;
	@Value("${spring.rabbitmq.port}")
	public int port;
	@Value("${spring.rabbitmq.username}")
	public String username;
	@Value("${spring.rabbitmq.password}")
	public String password;
	@Value("${spring.rabbitmq.virtual-host}")
	public String virtualHost;

	@Value("${spring.rabbitmq.queue.name.prefix}")
	private String queueNamePrefix;
	@Value("${spring.rabbitmq.queue.key.prefix}")
	private String queueKeyPrefix;

	private ConnectionFactory connectionFactory;

	private DirectExchange exchange;

	private RabbitAdmin admin;

	private AmqpTemplate amqpTemplate;

	public void init() throws IOException, TimeoutException {
		initConnectionFactory();
		initDirectExchange();
		initRabbitAdmin();
		initRabbitTemplate();
	}

	/**
	 * 创建连接工厂
	 * 
	 * @throws TimeoutException
	 * @throws IOException
	 * 
	 * @className:ConnectionFactory
	 * @description:
	 */
	public void initConnectionFactory() throws IOException, TimeoutException {
		CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
		connectionFactory.setHost(this.host);
		connectionFactory.setPort(this.port);
		connectionFactory.setUsername(this.username);
		connectionFactory.setPassword(this.password);
		connectionFactory.setVirtualHost(this.virtualHost);
		connectionFactory.createConnection();
		this.connectionFactory = connectionFactory;
	}

	/**
	 * 1.定义direct exchange，绑定queueTest 2.durable="true" rabbitmq重启的时候不需要创建新的交换机
	 * 3.direct交换器相对来说比较简单，匹配规则为：如果路由键匹配，消息就被投送到相关的队列
	 * fanout交换器中没有路由键的概念，他会把消息发送到所有绑定在此交换器上面的队列中。
	 * topic交换器你采用模糊匹配路由键的原则进行转发消息到队列中 key:
	 * queue在该direct-exchange中的key值，当消息发送给direct-exchange中指定key为设置值时，
	 * 消息将会转发给queue参数指定 的消息队列
	 * 
	 * @className:ConnectionFactory
	 * @description:
	 */
	public void initDirectExchange() {
		DirectExchange directExchange = new DirectExchange("wifi_exchange", true, false);
		this.exchange = directExchange;
	}

	public void initRabbitAdmin() {
		this.admin = new RabbitAdmin(this.connectionFactory);
	}

	public void initRabbitTemplate() {
		RabbitTemplate template = new RabbitTemplate(this.connectionFactory);
		RetryTemplate retryTemplate = new RetryTemplate();
		ExponentialBackOffPolicy backOffPolicy = new ExponentialBackOffPolicy();
		backOffPolicy.setInitialInterval(500);
		backOffPolicy.setMultiplier(10.0);
		backOffPolicy.setMaxInterval(10000);
		template.setRetryTemplate(retryTemplate);
		this.amqpTemplate = template;
	}

	/**
	 * @param message:
	 * @throws TimeoutException
	 * @throws IOException
	 */
	// 需要发送的数据
	public void sendMessage(Object obj) throws IOException, TimeoutException {
		if (!hasInit) {
			init();
		}
		String exchangeName = exchange.getName();
		String queueName = queueNamePrefix;
		String queueKey = queueKeyPrefix;

		Queue queue = new Queue(queueName, true);
		admin.declareQueue(queue);

		logger.info("往{}发送消息：{}", queueName, obj);
		Binding binding = BindingBuilder.bind(queue).to(exchange).with(queueKey);
		admin.declareBinding(binding);

		amqpTemplate.convertAndSend(exchangeName, queueKey, JSON.toJSONString(obj));

	}
}
