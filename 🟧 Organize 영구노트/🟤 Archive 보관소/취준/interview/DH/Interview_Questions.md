# Hiring Manager Interview Questions
**Candidate:** JunHyung Son  
**Position:** Backend Developer  
**Date:** November 23, 2025

---

## Technical Questions

### Database & Performance Optimization

1. **Full-Text Index Implementation**  
   You mentioned achieving a 46% performance improvement (18.6s→10s) by applying Full-Text Index. Could you walk me through how you identified that Full-Text Index was the right solution, and what challenges did you face during implementation?

at first, I tried to check the performance of query that is searching the name of discussion room and book title. But performance is not good, because it is searching about the text data, so it applyed full scanning.
so I applyed full-text index, but performance is not much improved what i thought.
and I tried to find a reason and I found there was a index fagmentation. So i rebuild the index, and performance is improved.

2. **Index Fragmentation**  
   You built a monitoring system for Index Fragmentation. What threshold did you use to determine when to rebuild indexes, and how did you decide that 10% fragmentation warranted a WARN level alert?

actually, it was knowned by that at least 10% of rate is effective to rebuilding the index, so we accepted that threshold.

4. **MySQL Optimization**  
   You identified 6 bottleneck APIs through slow query log analysis. Can you describe your process for analyzing slow query logs and share an example of one specific optimization you implemented?

most of the bottleneck APIs are performing well by using indexes. One specific optimization is using a covering index in query. I don't want to spend a lot of time dealing with disk i/o. So i divided one complex query into two querys, and apply composite index to each, then both querys are satisfied by the covering index.

### Infrastructure & DevOps

5. **Zero-Downtime Deployment**  
   You established zero-downtime deployment using ALB and GitHub Actions. Could you explain the rollback strategy you implemented and how you ensure database schema changes don't break during rolling updates?

I'll explain about zero-downtime deployment strategy. first, we check the image of new version, and start deploy first production server. when there is matter, automatically deploy lastest version. when the deploy is finish, doing health check. if it is success, then deploy another server in the same way.
Regarding database schema changes during rolling updates, we use flyway to maintain user data.

7. **Load Testing & Capacity Planning**  
   You conducted load tests with K6 targeting 200 TPS across 15 core service flows. How did you determine that 200 TPS was the right target, and what was your approach to designing weighted tests versus single tests?

In my case, the initial target number of users was 2000. So, I thought that the maximum number of concurrent users was 200, and I decided that the goal for tps was 200.

First, I proceeded with the main page entry test. In that case, the tps satisfied the 200 goal when the number of concurrent users was 500. At that time, the number of threads was 3. This figure was determined by the number of CPUs.

But when I proceeded with the weighted test, the result changed. The approach for the weighted test was to consider the actual user scenario. The maximum tps was 100 when the number of threads was 10 and the Hikari connection pool was 5, so we added one more server, and we achieved the goal of 200 tps.


9. **AWS Architecture**  
   Looking at your AWS experience with EC2, S3, RDS, and ALB, how would you design a scalable architecture for a service that needs to handle unpredictable traffic spikes?

10. **Monitoring & Observability**  
   You've worked with Loki, Prometheus, and Grafana. What key metrics do you monitor for a Spring Boot application, and how do you set up alerts to catch issues before they impact users?

### Architecture & Design

9. **Multi-Module Structure**  
   You introduced a Multi-Module Structure based on 4-Layered Architecture in the Ee-Seon-Jwa project. What were the key benefits you observed, and how did you decide which modules should be separated?

10. **Event Storming**  
    You implemented Event Storming to improve team collaboration. Can you share a specific example where Event Storming helped resolve a domain understanding conflict within your team?

### Spring Framework & Java

11. **Tomcat/HikariCP Optimization**  
    You optimized Tomcat and HikariCP settings. What specific configuration changes did you make, and how did you validate that these changes improved performance?

12. **Spring Boot Best Practices**  
    Based on your experience, what are the most common performance pitfalls you've seen in Spring Boot applications, and how do you prevent them?

---

## Behavioral Questions (Bar Raiser Style)

### Ownership & Delivery

13. **Taking Initiative**  
    You proposed documentation and issue management systems for your team. What specific problem were you trying to solve, and how did you convince your team to adopt these new processes?

14. **Driving Results**  
    The TodokTodok project shows impressive performance improvements. Can you walk me through the most challenging technical problem you solved in this project, from identification to implementation to measuring success?

### Customer Obsession

15. **User Impact Focus**  
    When you were optimizing performance from 18.6s to 10s, how did you prioritize which performance issues to tackle first based on user impact?

16. **Quality Standards**  
    You've implemented monitoring and alerting systems. How do you balance moving fast with maintaining high quality standards, especially when deadlines are tight?

### Learn & Be Curious

17. **Learning Approach**  
    Your summary mentions building a learning pipeline integrating GitHub-Obsidian-Notion with Claude MCP. What motivated you to build this system, and how has it changed the way you learn and retain technical knowledge?

18. **Deep Dive**  
    You mentioned "diving deep to find the true essence beneath the surface." Can you share an example where this approach led you to discover a root cause that wasn't immediately obvious?

### Collaboration & Communication

19. **Pair Programming Experience**  
    From your Woowa Tech Course experience, can you describe a challenging pair programming session where you and your partner had different approaches to solving a problem? How did you resolve it?

20. **Knowledge Sharing**  
    You mentioned establishing environments where developers can share knowledge and grow together. Can you share a specific example of how you facilitated knowledge sharing in your team?

### Hire & Develop the Best

21. **Continuous Improvement**  
    You've completed multiple educational programs (Woowa Tech Course, nbCamp). How do you identify gaps in your knowledge, and what's your approach to systematically filling those gaps?

22. **Feedback Culture**  
    Through code reviews in Woowa Tech Course, what's the most valuable feedback you've received, and how did you apply it to improve your work?

### Bias for Action

23. **Quick Decision Making**  
    When you identified the 6 bottleneck APIs, how did you prioritize which ones to fix first, especially if you had limited time before a deadline?

24. **Calculated Risks**  
    Implementing zero-downtime deployment is a significant infrastructure change. How did you test and validate your approach before rolling it out to production?

---

## Scenario-Based Questions

25. **Production Incident**  
    Imagine you receive a Slack alert at 2 AM indicating that index fragmentation has reached 30% on your most critical table, and users are reporting slow response times. Walk me through your response process.

26. **Architectural Decision**  
    If you were to build the TodokTodok service from scratch today, knowing what you know now, what would you do differently in terms of architecture and technology choices?

27. **Trade-off Analysis**  
    You need to implement a new feature that requires complex joins across multiple tables, which could impact the performance you've worked hard to optimize. How would you approach this trade-off between feature development and performance?

---

## Cultural Fit & Motivation

28. **Why Delivery Hero?**  
    Based on your experience and interests, what aspects of Delivery Hero's technical challenges are you most excited about?

29. **Long-term Vision**  
    Looking at your career trajectory, where do you see yourself in 3-5 years, and how does this role at Delivery Hero align with that vision?

30. **Team Dynamics**  
    You've experienced both winning the best project award and working in collaborative environments. What do you think are the key ingredients for a high-performing engineering team?

---

## Closing Questions for Candidate

- Do you have any questions about the technical challenges we're facing at Delivery Hero?
- What would you need from the team to be successful in your first 90 days?
- Is there anything we haven't covered that you'd like to share about your experience or approach to software development?

---

**Interview Notes:**
- Focus on STAR method responses (Situation, Task, Action, Result)
- Look for concrete examples with measurable outcomes
- Assess technical depth and problem-solving approach
- Evaluate cultural alignment with Delivery Hero values
- Note communication clarity and collaboration skills
