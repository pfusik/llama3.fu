llamafu.jar: MANIFEST.MF obj/LlamaJava.class
	jar cfm $@ $< -C obj .

obj/LlamaJava.class: LlamaJava.java transpiled/LlamaCli.java
	mkdir -p $(@D) && javac -d $(@D) $< transpiled/*.java

transpiled/LlamaCli.java: ../llama.fu ../llamacli.fu
	mkdir -p $(@D) && fut -o $@ $^

clean:
	$(RM) llamafu.jar obj/*.class transpiled/*.java
