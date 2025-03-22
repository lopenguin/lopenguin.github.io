# This file was generated, do not modify it. # hide
#hideall
using JSXGraph
println("~~~<script>$(JSXGraph.PREAMBLE)</script>~~~")

b = board("b2", xlim=[-0.2,2], ylim=[-0.2,1.0])
b ++ slider("v", [[0.3,-0.1],[1.3,-0.1],[0,0,0.2]], name="σ")
@jsf f(t) = 0
@jsf p1() = val(v)*1.239
@jsf p2() = p1() + val(v)*0.634
@jsf p3() = p2() + val(v)*1.002
@jsf p4() = p3() + val(v)*-0.015
@jsf p5() = p4() + val(v)*-0.296
@jsf p6() = p5() + val(v)*-1.387
@jsf p7() = p6() + val(v)*3.203
b ++ plot(f, a=0, dash=2)
b ++ point(0, 0, withlabel=false)
b ++ point(0.25, p1, withlabel=false)
b ++ point(0.5, p2, withlabel=false)
b ++ point(0.75, p3, withlabel=false)
b ++ point(1.0, p4, withlabel=false)
b ++ point(1.25, p5, withlabel=false)
b ++ point(1.5, p6, withlabel=false)
b ++ point(1.75, p7, withlabel=false)

print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""")