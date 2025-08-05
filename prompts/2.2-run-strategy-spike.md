# Stage 2: Strategy-Level Discovery Spike

You are conducting a discovery spike at the Strategy stage to explore technical approaches, architectural patterns, and key technology decisions.

## Strategy-Specific Spike Focus

Strategy-level spikes typically explore:
- **Technology choices**: Which frameworks/languages/platforms?
- **Architectural patterns**: Monolith vs microservices? Event-driven?
- **Integration approaches**: How to connect with existing systems?
- **Performance characteristics**: Can we meet requirements?
- **Security implications**: What are the risks?
- **AI/ML feasibility**: For agent-based systems

## Common Strategy-Stage Questions

- Which tech stack best fits our needs?
- What architectural pattern supports our scale?
- How do we integrate with System X?
- Can Technology Y handle our performance needs?
- What are the security implications of Approach Z?
- For AI: Which LLM? What prompt patterns work?

## Instructions

Follow the general spike process from `run-discovery-spike.md` with these strategy-specific additions:

1. **Technology Evaluation**:
   - Build hello-world examples
   - Benchmark performance
   - Test integration capabilities
   - Evaluate learning curve

2. **Architecture Prototypes**:
   - Create minimal architectural demos
   - Test communication patterns
   - Measure latency/throughput
   - Validate scalability approach

3. **AI/ML Exploration** (if applicable):
   - Test different models
   - Experiment with prompts
   - Measure response quality
   - Evaluate costs

## Strategy Spike Report Additions

Include these strategy-specific sections:

### Technology Assessment
- Pros/cons of each option
- Performance benchmarks
- Cost implications
- Team expertise required

### Architecture Validation
- Pattern strengths/weaknesses
- Scalability projections
- Complexity assessment
- Risk analysis

### Integration Findings
- API compatibility
- Data format challenges
- Authentication approaches
- Error handling needs

### AI/ML Insights (if applicable)
- Model performance comparison
- Prompt engineering findings
- Cost per interaction
- Reliability measures

## Update Progress Report

After completing this spike:
1. Update `reqs/progress-report.md`:
   - Mark spike complete in Stage 2
   - Add technology decisions to decisions section
   - Note any new complexity discovered
   - Update recommended architecture
   - Add to activity log

Remember: Strategy spikes determine HOW we'll build, not WHAT we'll build.