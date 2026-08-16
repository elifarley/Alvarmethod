# How I Use AI to Learn Things

- **Speaker:** Eero Alvar
- **Video:** https://youtu.be/kzcI5F4tGiU
- **Channel:** https://www.youtube.com/channel/UCGmPSaSxslbRUKPTbGk8ENQ
- **Uploaded:** 2026-08-14
- **Length:** 18:58
- **Note:** Auto-captions, lightly cleaned. Not a substitute for the video. Included so this repo can credit and implement the method.

## Chapters

- 0:00 Intro
- 0:25 How we're used to learning
- 0:55 One teaches many
- 1:42 One learns from many
- 3:08 One-to-one
- 4:22 The approach
- 5:13 The process
- 8:01 Demo
- 10:12 Probe
- 12:07 Plan
- 13:04 Teach
- 17:54 Close

## Transcript

How could we use AI to learn better? I mean, there's got to be some way to optimize learning with AI. I think it's the perfect tool for it. It is not entirely clear yet how. So yeah. This video will be me sharing my own current approach to this. First, I'll go through the reasoning behind the approach and the design, and then we'll do a live demo.

All right. So this is the standard way of learning that we're used to. Each outlet — so a teacher, a book, a course, whatever — they all are designed to teach many students. And also, each student learns from many outlets. So there's a many-to-many relation between the learners and the outlets, and both directions of it produce their own kind of inefficiency.

First, one outlet teaches many. An outlet that's designed for many people cannot be optimal for any one of them. That's because optimal teaching would clearly depend entirely on the learner's current understanding. And this includes both the whole teaching arc from their current understanding to their goal understanding, as well as each explanation along the way.

An optimal teaching path then would be one that minimizes teaching stuff that the learner already holds, and also stuff that they can't yet understand. So it would work exactly at the edge of their understanding. So ideally, a teacher would have exactly one student.

All right. So second direction: one student learns from many outlets. This means many teaching styles to get used to, many notations, many levels of reliability, many interfaces, and the switching between them costs mental effort that's not gone into learning the material.

But I think there's a much deeper cost in this, which is trust. With an unfamiliar outlet, I think the brain kind of hedges. So it won't fully commit to accepting a fact until the outlet has proven itself and is familiar enough.

I think a good way to illustrate this is the following example. Let's say we want to understand the hairy ball theorem, and we have two identical explanations. But the other one is in a 3Blue1Brown video, and the other is on X posted by some random guy. Now, even though the explanations are identical, I think it is clear that we're going to learn better from the familiar source. The brain is going to have a much easier time internalizing the information when it trusts the outlet, even though the explanation is identical.

All right? So ideally, a student would have exactly one teacher.

Now, we've established that the ideal scenario is one-to-one in both directions, but there's an obvious objection to this, which is that having only one teacher means getting only one perspective. But I think that the objection conflates a source with an interface. So a teacher doesn't reduce the number of sources, perspectives. Instead, it aggregates all of them and delivers them through one interface. So we don't lose many perspectives.

Now, with AI being the teacher, trust isn't really built over time. Rather, it's engineered into the system. The reason we have to have reliable verification and fact-checking is one, correct information. Obviously, we absolutely don't want the AI to hallucinate false information. But also two, because it makes learning easier when we know that the system is reliable. So: one interface fitted to one mind over all sources.

Now, the two inefficiencies that we went over, they give us the two principles that the system runs on. First, optimized teaching, the answer to the first inefficiency. And two, optimized allocation of mental resources, answer to the second one.

And this does not mean removing difficulty. Instead, it's about concentrating all cognitive work into the material itself. We want to maximize struggle. We want to learn difficult things, so struggling is very important, but it has to be in the material itself and not in logistics, planning, finding resources, verifying facts, figuring out what to learn and in what order. All of that is for the system to absorb.

Next, the actual process, how this is implemented.

First, optimized teaching. To teach optimally — whatever this might be — is very different from person to person, but in order to do that, the system obviously needs to know the person's exact current understanding. So it has to measure, and it does this with a quiz tool, which lets it ask graded multiple-choice questions. It starts off with very broad [questions] and then basically binary-searches the edge on every possible strand that the lesson will depend on. So it's going to get a very detailed map of the learner's understanding. So that's phase one, probe.

Second, phase two is plan. Basically just reasons everything out. How do I teach this mind this specific thing? And here's also where it fires off its first verification and fact-checking sub-agents. And then presents the plan as a mermaid graph and diagram.

And okay, basically two reasons for why it has to show a graph. One, it gives the learner a better sense of what's to come. And also two, the actual reason I implemented it is to actually force the AI to reason everything out. That's the real reason. It cannot just cheat and wing it.

And then finally, the teaching itself. And this phase is going to be very different because it's going to depend entirely on how you want to learn. You want to install the system with your own learning philosophy and how you learn best.

But one detail that I think is going to be important regardless of the exact way of learning is feedback. So the AI is going to quiz you periodically to check whether you actually understood the thing. And this is important for three reasons.

One, it's very easy to sort of gaslight yourself into thinking that you understood something, especially when learning with AI. So actually testing your understanding is important feedback for yourself.

Two, the system needs continuous feedback to stay calibrated.

And three, applying the material, doing practice problems, using the stuff that you learned, also just helps you learn better. It's a part of how the new information and the new understanding locks in.

So yeah. That's the general idea. Now, let's see it in action.

All right, we're in the Pi Agent harness now in my learning directory. And yeah, this is where I've got everything set up. So, in the `.pi` folder, I've got the teach skill, some visualization stuff, the quiz extension, the MD log extension, which I'll show you in a bit, and two subagents to make visuals.

I think the only way to demo a system like this is actually to try to learn something. And to really go full circle, in my previous learning-related video, I mentioned Maxwell's equations and how they can be expressed in just two equations using differential forms. And as you can see, I don't really know anything about differential forms. So I think this is what we're going to learn today. Now, obviously, we're not going to get to this level, but I think this is a very good example to showcase the system with an actual learning process.

Let me pull up Obsidian here because this is what I use. It's sort of like the UI for everything. Learning differential forms. This is what the MD log extension is for. It lets me link a Markdown file to the session, and then everything is going to get printed right here. Just a nicer way to see things and also get the LaTeX rendering. So yeah, that's my solution. And yeah, it's also nice to have persistence artifacts from each learning session.

Let's begin. Teach. I want to get like a solid introduction to differential forms.

And we're using [a strong model] because I really found that the intelligence of the model really matters in teaching. The teaching instructions are quite specific.

We're going to get questions now.

A force field F acts on a particle as it moves along a curve C. What does the line integral compute?

Let me also — I've got this note here where I can just yap into. Basically, just to give it more context and sort of talk through my reasoning.

It's not going to be number one. I mean, number one does hold for conservative fields, but for any force field F, it's going to be number three. The net work done by the field on the particle.

All right, next one. The divergence of a vector field at a point measures the net outward flux per unit volume at that point.

All right, now the Stokes theorem. Yes.

And now we get Faraday's law of induction. I mean, you can always just give it more context at the beginning about what stuff you already understand very thoroughly. In this case, I gave it very little context, so we're going to get a long probing phase.

Oh, we're going to have to go into relativity. In special relativity, when you change to a moving reference frame, what happens to the electric and magnetic fields?

Okay, let's read through these. Both are invariants. All observers measure the same E and B at each event. They mix. A purely electric field in one frame has both electric and magnetic parts in another. Hold on. Only E changes. B stays fixed. No, obviously not. Three, each transforms independently.

And I'll go ahead and answer I don't know. And it was two. They mix.

All right, it's stopped with questions. Finally done with the [probe]. It did ask a lot of questions, but now it's got a very detailed image of my understanding. And it's also just a nice warm-up as well. And I don't really got to worry about anything. Just answer the questions and it handles all the logistics.

Now we've got a researcher still going on fact-checking stuff. Although usually math isn't really something it would need to fact-check. But well, it's good practice anyway. Then after this, it's going to fully plan everything out.

All right, finally, we're getting the plan. I did start rendering the mermaid… anyway, we get it in the Obsidian. This is the plan. Let's go. A lot of things. I'm going to be reading the plan.

All right, so that's cool. We're going to get to generalized Stokes well before the actual goal.

Okay, perfect. It's using the visualization skill. So we're going to get some visuals soon. All right, it's making an SVG. And the reason that these are done in sub agents is to obviously preserve context but also the sub agents will look at the image to verify whether it actually looks correct. It wrote an SVG and now it's going to view it. It's going to edit it a bit, look at it again.

Yes. So we're going to get that in the next message. But now the first node. So it's going to slowly walking down the path one reasoning step at a time.

Because what usually happens if you're like talking to ChatGPT or something trying to get it to explain or teach you anything, it usually just — it's way too excited and it rushes through the whole thing. And so I like to keep this very slow, one reasoning step at a time.

So now we're introducing covectors. Let me read through this.

All right. So now it's introduced covectors and also given a new perspective on the X. This is really cool. Yeah, it's going to quiz me on this reasoning step to confirm that everything is actually understood, to confirm my understanding.

Now, yeah, it's going to incorporate the visual which will be all rendered into Obsidian and automatically here as an embedded file.

Let alpha be 3 dx minus 2 dy and V this. What is alpha of V? Which is going to be -4.

Okay, this makes perfect sense. The picture helped.

Oh yeah, Pi also got like built-in LaTeX rendering. Okay, which is kind of cool. Yeah, it does the job but it's definitely not the same as this.

All right, so now we're extending the covectors to a covector field. All right, so now we get a new perspective on what the line integral actually is.

One thing I don't like about this is I haven't really configured its style of speaking. So we get a lot of — it sounds very AI, which I don't really mind because I don't want to cram it with too many instructions to worry about. So I'm fine with these LLM-isms. It's not X, it's Y.

Wow, insane. The quality of the teaching is what matters. But yeah, it's basically walking down the dependency tree.

So when we're going to get — I think this is the wedge product. But yeah, I like that it moves one reasoning step at a time. So if at any point I have questions, I can always ask. And it doesn't rush forwards. Each step is very easy to digest. And it's going to give me everything that I can accept at face value like this.

All integration over a one-dimensional thing is the integration of a one-form. Now, I assume that this continues, yeah. A k-form will be the kind of thing a k-dimensional surface can eat. Sure.

All right, we're getting a new SVG. Seems like our SVG maker died. Agent error. Overloaded. Bro, not now. Trying to learn differential forms.

Oh no, we're getting it. Now we're getting the wedge products. That's cool. Machines that are bilinear and antisymmetric. Yeah, where do we get them? I'm sure this is not antisymmetric. The minimal fix is the oldest trick in the book. Aha. Yeah, that gives something anti-symmetric.

So, is that just what it is? Sure, okay, fine. But yeah, anyway, this is — we're obviously not going to go through the whole dependency graph here.

Where did we get to in the DAG? Here. Yeah, I think we got here. Yeah, we're approaching generalized Stokes now. Yeah, that's cool. But yeah, I think this is enough for a demo.

So this has been sort of a second part or continuation of where we left off last time in my previous learning related video. So what this video has been really about is how to take a learning philosophy or way of teaching and implement that as an AI system.

I think the main reason for why this has worked so well for me is none of the stuff I talked here about, rather just the style of teaching I covered in the previous video, which affects exactly two things: the learning arc, the path that we're going to take from our current understanding to our goal understanding, and two, the individual steps and explanations along the way.

Yes. Anyway, just some ideas for you to think about. I'd like to hear your thoughts on this. And how could the system be improved? How do you use AI in learning? I'd like to know. I'm very invested into refining this further. So yeah, that's it.
